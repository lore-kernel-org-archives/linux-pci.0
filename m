Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 27 Oct 2016 13:12:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick Kerkhof <rick.2889@gmail.com>
Cc: Peter Wu <peter@lekensteyn.nl>, linux-acpi@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161027101204.GB1476@lahna.fi.intel.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al>
 <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
 <CANni8hfSnT46pH8EnA1f00SWXUrJ=8PHRjydricGbH4AS4mR7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANni8hfSnT46pH8EnA1f00SWXUrJ=8PHRjydricGbH4AS4mR7A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 27, 2016 at 10:07:45AM +0000, Rick Kerkhof wrote:
>    Thank you for the patch, I have applied it to the kernel sources but
>    I'm not sure how to proceed from now on. Should I compile the whole
>    kernel or can I just build an out-of-tree acpi module?

You need to build the whole kernel, install and reboot.
