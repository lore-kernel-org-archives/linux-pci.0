Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Sep 2016 11:50:18 -0400
To: Steve Kenton <skenton@ou.edu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        yinghai Lu <yinghai@kernel.org>,
        Blackmagic Developer Support <developer@blackmagicdesign.com>
Subject: Re: lspci not showing motherboard ethernet controller after PCIe
 card firmware update change from 32-bit to 64-bit BAR
Message-ID: <20160926155018.GL14311@csclub.uwaterloo.ca>
References: <2cc60cd1-bab1-a086-2326-7ce161b8f083@ou.edu>
 <efdbf332-841c-7617-efd1-facf785472fd@ou.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <efdbf332-841c-7617-efd1-facf785472fd@ou.edu>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 24, 2016 at 07:24:14PM -0500, Steve Kenton wrote:
> I have two different systems with Blackmagic Design Intensity Pro-4K
> cards. One uses an ECS H81H3-I motherboard and the other uses a Gigabyte
> GA-H110N motherboard. Previously both were working properly. When I
> upgraded the Blackmagic Design desktopvideo package from version 10.7 to
> version 10.8 it included an update of the firmware on the cards from
> version 0x85 to 0xbd. After the  upgrade the Gigabyte-motherboard system
> continues to work properly, but the ECS-motherboard system no longer
> shows the motherboard ethernet controller with lspci. Downgrading the
> firmware makes the ethernet controller reappear with lspci. Upgrading
> again makes it disappear again. Attached are the output of lscpi -vv
> for each version of the firmware on the ECS-motherboard system.
> Upgrading to the most recent ECS-motherboard bios did not have any effect.
> 
> There are a number of differences in the two lspci outputs but
> based on conversations I've seen on LKM, which I peruse but am not
> subscribed to, I suspect that this is the important one:
> 
> lspci-Intensity-Pro-4K-10.7-firmware.txt:    Region 0: Memory at
> f7d00000 (32-bit, non-prefetchable) [size=1M]
> lspci-Intensity-Pro-4K-10.8-firmware.txt:    Region 0: Memory at
> f7c00000 (64-bit, non-prefetchable) [size=1M]
> 
> The Engineers at Blackmagic Design have confirmed that the change to a
> 64-bit BAR with firmware version 0xbd was intentional and correct. And
> to be clear, the Blackmagic cards continue to work properly. The issue
> is the motherboard ethernet controller disappearing after upgrading the
> Blackmagic cards to new firmware with a 64-bit BAR. Note, however, that
> 64-bit BAR is below 4GB with the high four bytes being all zeros. After
> the firmware update it's like there is "no room at the inn" for the
> motherboard ethernet controller so it never gets enabled. I think we can
> all agree that it's a likely a problem with the PC motherboard bios. I'm
> hoping to find a workaround to allow me to configure a number of
> existing ECS-motherboard systems in the field for use with the new firmware.
> 
> I normally run Ubuntu 14.04 LTS and tried the most recent 4.4.0-38
> kernel but then I noticed that the Ubuntu 16.10 daily build ISO switched
> to kernel 4.8-RC-something on Sept 21st. So I booted that
> livedvd and tried it to see if 4.8-RC included some recent PCIe
> 32-bit/64-bit resource fix but sadly the results were the same. With
> firmware 0xbd, the ethernet controller was still missing from the lspci
> output. I poked around with various of the kernel pci= parameters such
> as bios and nobios to no avail, but I really am out of my depth here.
> 
> I'm available to run tests if anyone has any suggestions.

Well pci=bios is 32 bit only, so that doesn't work, pci=bfs was probably
supposed to be pci=bfsort.  It sure looks like the bios fails to allocate
the network device when the other device is 64 bit.  Sure looks like
a bios bug.  I see nothing indicating that the address space ran out.
It looks fine.

You could try:

pci=realloc
pci=assign-busses
pci=bfsort (the one I think you were trying to do).

I certainly wouldn't be surprised if the only thing ever tested in that
board was a graphics card.

Of course your network card is also 64 bit bar (when seen), so the system
can work with such.  Makes one wonder if the bios has a bus, or the H81
has a limit that only one of the ethernet and the add in card can use
64 bit bar at a time.  That would seem weird of course.

-- 
Len Sorensen
