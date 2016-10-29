Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Zheng, Lv" <lv.zheng@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Wu <peter@lekensteyn.nl>
CC: Rick Kerkhof <rick.2889@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Date: Sat, 29 Oct 2016 00:49:22 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A25E770@SHSMSX101.ccr.corp.intel.com>
References: <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com> <20161027160648.GF27017@al>
 <20161028085630.GD1476@lahna.fi.intel.com> <20161028110930.GA1521@al>
 <20161028111907.GD23812@lahna.fi.intel.com> <20161028123041.GB1521@al>
 <20161028141000.GE23812@lahna.fi.intel.com>
In-Reply-To: <20161028141000.GE23812@lahna.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Mika
> Westerberg
> Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU via Power Resources
> 
> On Fri, Oct 28, 2016 at 02:30:41PM +0200, Peter Wu wrote:
> > It was correctly applied. I did some testing with QEMU, it seems that
> > the \_OSI check is problematic. Removing it makes things work again.
> 
> I hope Bob and Lv can answer why _OSI fails.
> 
> In the meantime I think we should check flags.power_resources in nouveau
> driver (in addition to _PR3) so that it falls back to _DSM if there are
> no power resources (or if we failed to evaluate them for some reason).

IMO, the problem wasn't _OSI, the problem was "If".
"If" is module level here.
So execution order of it in current Linux upstream may be different from Windows.

You can try to modify acpi_gbl_parse_table_as_term_list to TRUE.
To see if this can be solved.

Thanks and best regards
Lv

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
