Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1521105992.18237.2.camel@suse.com>
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
From: Oliver Neukum <oneukum@suse.com>
To: Richard Leitner <richard.leitner@skidata.com>,
        Richard Leitner <dev@g0hl1n.net>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bhelgaas@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Date: Thu, 15 Mar 2018 10:26:32 +0100
In-Reply-To: <377fb9d5-1cc9-7ab8-c965-2fb0a4dc20f3@skidata.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
         <20180314102933.21367-3-dev@g0hl1n.net> <1521029854.4511.12.camel@suse.com>
         <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
         <1521041253.4511.16.camel@suse.com>
         <377fb9d5-1cc9-7ab8-c965-2fb0a4dc20f3@skidata.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 14.03.2018, 16:44 +0100 schrieb Richard Leitner:
> On 03/14/2018 04:27 PM, Oliver Neukum wrote:
> > Am Mittwoch, den 14.03.2018, 14:31 +0100 schrieb Richard Leitner:
> > > 
> > Well, but it does not. Removing a redundant definition is a clear
> > benefit. But you are not removing a definition. You are introducing
> > a preprocessor constant. Why?
> > What is its benefit?
> 
> AFAIK pci_ids.h collects PCI vendor and device IDs in one single 
> point. As the PCI vendor ID of Netlogic is used in multiple files
> IMHO it would be a good idea to add it to pci_ids.h and furthermore
> remove it from arch/mips/include/asm/netlogic/xlp-hal/iomap.h (where
> it's currently defined).
> 
> Or am I getting things wrong?

I think so, yes. We are giving names to constants as a form
of comment or to change them at multiple places at once and
consistently.

So

#define XYZ_NETDEV_RESET_RETRIES	2

makes clearly sense. So does

#define XYZ_MAGIC_VALUE1	0xab4e

because it tells you that you have a magic value.
But you will never redefine a PCI vendor ID. In fact you
must not. And if you have a comparison like

dev->vID == 0x1234

if you change this to

dev->vID == SOME_VENDOR_ID

what good does this to you? You already knew it was a vendor ID.
Now you can name it at a glance. So what? If you have a device
you will have to check whether you have some OEM version. You
will always go and check the raw number. And if you have a log
and need to check whether the check will be true, you will have
a number.
Using a constant there is nothing but trouble. Yet one more grep.

	Regards
		Oliver
