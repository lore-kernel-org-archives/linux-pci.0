Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:51811 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847Ab3EFWqg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 May 2013 18:46:36 -0400
Received: by mail-oa0-f49.google.com with SMTP id l20so3975800oag.22
        for <linux-pci@vger.kernel.org>; Mon, 06 May 2013 15:46:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130506224235.GB50060@bingao-desk1.fm.intel.com>
References: <20130430072147.GA37866@bingao-desk1.fm.intel.com>
 <CAErSpo6g0xXo+HH+ZOYZav_Y6ZUH2D2FAqN+uDqrJqxQCRObog@mail.gmail.com>
 <20130502065358.GA41008@bingao-desk1.fm.intel.com> <CAErSpo66x7eHOy3nqH5kgKjOd-176zgNs3EGpJxYrk1dcKPQPg@mail.gmail.com>
 <CAErSpo4GPMD1kSW7qxBvQmN30NOyx_KruzsFY6SVXkFRMBcDmQ@mail.gmail.com> <20130506224235.GB50060@bingao-desk1.fm.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 6 May 2013 15:46:13 -0700
Message-ID: <CAErSpo4ZuoX27H+rRGfRpsJK6W+sWxi7xQuQqP_Rr_cGcRRSZQ@mail.gmail.com>
Subject: Re: x86/pci/mrst: force all pci config toward 0:0:0, 0:2:0 and 0:3:0
 to type 1
To: Bin Gao <bin.gao@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Mon, May 6, 2013 at 3:42 PM, Bin Gao <bin.gao@linux.intel.com> wrote:
> On Mon, May 06, 2013 at 11:56:38AM -0700, Bjorn Helgaas wrote:
>> I hate it when I go to the trouble of reviewing something and asking
>> relevant questions, and then people ignore the questions :(
> Sorry for that.
>
>> I'd still like to know whether multi-function devices are possible at
>> bus 0, device 0, 2, or 3.
> 0000:00:00.0 is host bridge.
> 0000:00:02.0 and 0000:00:03.0 are single-function devices.
>
>> Are these devices built-in, so you know exactly what they are and they
>> can never be anything else?
> Yes, they are built-in devices and I know exactly what they are.
>
>> Or is there a slot or other way to connect a user-chosen device?
> No, not that way.
>
>> If you included "lspci -vv" output, that would make this much easier
>> to talk about.
> I'm sorry the busybox shrinks lspci options so it doesn't have
> meaningful ouput excpet for DID:VID and class code.

All right, I applied this and will ask Linus to put it in v3.10.

Bjorn
