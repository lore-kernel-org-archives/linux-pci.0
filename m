Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120210023717.10311.37310.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com> <20120210023717.10311.37310.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Feb 2012 18:43:03 -0800
Message-ID: <CAErSpo6GpZ7arxCyfZw07pHz1K8FPuUagZhRCGHf5i+PtiH-FA@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] mips/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Yoichi Yuasa <yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 9, 2012 at 6:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Tell the PCI core about host bridge address translation so it can take
> care of bus-to-resource conversion for us.
>
> Here's the wrinkle on Cobalt: we can't generate normal I/O port addresses
> on PCI because the GT-64111 doesn't do any address translation,

Yuasa-san, thanks for testing v1 of this series.  I hope this v2
series fixes the problem you saw.  Let me know if it doesn't.

Bjorn
