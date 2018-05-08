Return-Path: <SRS0=4wHE=H3=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=4wHE=H3=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: AER: Malformed TLP recovery deadlock with NVMe drives
To: Bjorn Helgaas <helgaas@kernel.org>, okaya@codeaurora.org
Cc: Alex_Gagniuc@dellteam.com, Shyam.Iyer@dell.com,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, Austin.Bolen@dell.com, linux-pci-owner@vger.kernel.org
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
 <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>
 <9fc90040d5712282ea223807ace39312@codeaurora.org>
 <1125ddf8-f342-3f8f-90ee-0aa94287360c@gmail.com>
 <16bdb0febb842ad0980db9214c8076c5@codeaurora.org>
 <3d4991bc2948430d910a16da36c90b91@ausx13mps321.AMER.DELL.COM>
 <1fdfaaa47ad782ee864f24c5a75a355a@codeaurora.org>
 <20180508165849.GC9529@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <bb358683-79fc-0590-eb93-70f4c3c922da@gmail.com>
Date: Tue, 8 May 2018 12:32:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180508165849.GC9529@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 05/08/2018 11:58 AM, Bjorn Helgaas wrote:
(snip)
> https://bugzilla.kernel.org/show_bug.cgi?id=199657
> 
> Thanks for the bugzilla.  Can you add the "lspci -vv"
> and also the specifics about how you inject the error

Done


> I don't know how you collected the dmesg logs

I hired scribes.


> (looks like maybe colorizing escape sequences?).

You mean the ANSI escape sequences. wget and cat in a color terminal.
You will get so used to this, you will love it so much, you won't ever
again want to open a a web page.


> always think it's nice to have the plain ASCII

dmesg without color information is like driving a car without a steering
wheel. You better have a very straight road and go very slow, or you'll
crash into something.

Alex
