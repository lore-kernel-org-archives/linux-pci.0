Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 28 Oct 2016 11:56:30 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Rick Kerkhof <rick.2889@gmail.com>, linux-acpi@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Robert Moore <Robert.Moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161028085630.GD1476@lahna.fi.intel.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al>
 <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
 <20161027160648.GF27017@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161027160648.GF27017@al>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 27, 2016 at 06:06:48PM +0200, Peter Wu wrote:
> On Thu, Oct 27, 2016 at 12:55:08PM +0300, Mika Westerberg wrote:
> > On Thu, Oct 27, 2016 at 09:42:28AM +0000, Rick Kerkhof wrote:
> > >    No, there are not. Here is the recursive directory listing:
> > 
> > Are you able to try the following patch and send me dmesg (or attach it
> > to that bug)? It should show if the ACPI core even tries to add those
> > power resources.
> 
> So Rick has tested this patch now on top of 4.8.4 (mainline fails to
> boot due to a kbuild issue which I reported elsewhere), but the output
> is empty. That seems to indicate that flags.power_resources is unset.

Is it completely empty or is it empty just for RP05? It should print out
all devices with power resources.

> Given that _PS3 exists and is indeed a package with some elements, it
> seems that acpi_extract_power_resources is failing. Note that in the
> SSDT, the power resource NVP3 was referenced before it was defined,
> could that result in this enumeration failure? Relevant SSDT excerpt:
> 
>     Scope (\_SB.PCI0.RP05)
>     {
>         Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
>         {
>             NVP3
>         })
>         // ...
>     }
> 
>     PowerResource (NVP3, 0x00, 0x0000)

That and the fact that they come from an SSDT instead of DSDT may cause
this. However, I'm not expert in ACPICA so adding Bob and Lv if they
have ideas.

Bob, Lv, the bug in question is: https://bugs.freedesktop.org/show_bug.cgi?id=98398
