Return-Path: <SRS0=wxkp=FC=nexb.com=pombredanne@kernel.org>
Return-Path: <SRS0=wxkp=FC=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:12:56 +0100
Message-ID: <CAOFm3uEfnG8kc4UNOAUq5Ycb+GpfZsA9Yymbmu6omuDYLPBxMg@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI: Add SPDX tags
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Fri, Jan 26, 2018 at 10:32 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to
> files with no license") added SPDX GPL-2.0 tags to several PCI files.
>
> These patches add SPDX tags to almost all remaining PCI files.  For ease of
> reviewing they're split into several cases (GPL v2, GPL v2+, etc.)

Better late than never: thank you ++ for this: my hero!

> One file (drivers/pci/hotplug/s390_pci_hpc.c) specifies only "GPL"; I don't
> know what to do with that, so I left it unchanged.

This is the way to go when there are ambiguities alright. One
interpretation of a bare GPL is GPL-1.0+ but the context matters a
lot!

-- 
Cordially
Philippe Ombredanne
