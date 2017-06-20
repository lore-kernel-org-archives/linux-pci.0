Return-Path: <SRS0=Mkam=5Z=canonical.com=kai.heng.feng@kernel.org>
Return-Path: <SRS0=Mkam=5Z=canonical.com=kai.heng.feng@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170619180111.GL11129@bhelgaas-glaptop.roam.corp.google.com>
References: <20170616094054.8044-1-kai.heng.feng@canonical.com> <20170619180111.GL11129@bhelgaas-glaptop.roam.corp.google.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 20 Jun 2017 10:42:02 +0800
Message-ID: <CAAd53p5p+eQVsJ4xgyMcV9VLZomdKYbgGjf-1VqL=kS-6rTVWQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Workaround AMD EHCI controller PME bug
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 2:01 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Applied (patch below) to pci/pm for v4.13, thanks!
>
> Note that I added parens because bitwise NOT is higher precedence than
> bitwise shift right, and I think we want the shift before the NOT.  Please
> double-check.

You are right. NOT should be the last operation here.

Thanks!
