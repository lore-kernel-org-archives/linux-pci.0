Return-Path: <SRS0=G+2+=5V=canonical.com=kai.heng.feng@kernel.org>
Return-Path: <SRS0=G+2+=5V=canonical.com=kai.heng.feng@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAd53p46piFcy+JKFi6auBLON-4tPHTAHBO_DOyZyL+xxCa4PA@mail.gmail.com>
References: <CAAd53p4-84G=NeJMOGcL_3fd7_s6EC4udLEGTcNNSBF=4FxHyA@mail.gmail.com>
 <Pine.LNX.4.44L0.1706151008380.1573-100000@iolanthe.rowland.org> <CAAd53p46piFcy+JKFi6auBLON-4tPHTAHBO_DOyZyL+xxCa4PA@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Sat, 17 Jun 2017 00:18:15 +0800
Message-ID: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 11:07 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> Those documents refer to a hardware bug with a workaround in the BIOS.
>> Have you checked to see if your BIOS is up to date?
>
> Yes, it's up to date.
>

Alan, I re-sent a patch but I forgot to add you to CC list:
http://marc.info/?l=linux-pci&m=149760607914628&w=2
