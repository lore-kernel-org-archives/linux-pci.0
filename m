Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 28 Oct 2016 17:10:00 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Rick Kerkhof <rick.2889@gmail.com>, linux-acpi@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Robert Moore <Robert.Moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161028141000.GE23812@lahna.fi.intel.com>
References: <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
 <20161027160648.GF27017@al>
 <20161028085630.GD1476@lahna.fi.intel.com>
 <20161028110930.GA1521@al>
 <20161028111907.GD23812@lahna.fi.intel.com>
 <20161028123041.GB1521@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161028123041.GB1521@al>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 28, 2016 at 02:30:41PM +0200, Peter Wu wrote:
> It was correctly applied. I did some testing with QEMU, it seems that
> the \_OSI check is problematic. Removing it makes things work again.

I hope Bob and Lv can answer why _OSI fails.

In the meantime I think we should check flags.power_resources in nouveau
driver (in addition to _PR3) so that it falls back to _DSM if there are
no power resources (or if we failed to evaluate them for some reason).
