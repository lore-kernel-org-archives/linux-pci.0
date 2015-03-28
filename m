Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34836 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbC1UT3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Mar 2015 16:19:29 -0400
MIME-Version: 1.0
In-Reply-To: <20150328.111621.1041514784349808716.davem@davemloft.net>
References: <551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<20150328.111621.1041514784349808716.davem@davemloft.net>
Date: Sat, 28 Mar 2015 13:19:28 -0700
Message-ID: <CAE9FiQVoDVZOsjZ827NDnTeQ6WiAWDvPays7RqYB4Q2Jy1nmMw@mail.gmail.com>
Subject: Re: d63e2e1f3df breaks sparc/T5-8
From: Yinghai Lu <yinghai@kernel.org>
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 28, 2015 at 11:16 AM, David Miller <davem@davemloft.net> wrote:
> PCI addresses being 64-bit or not is an attribute of the PCI
> controller and the geography of the bridges behind it, not the
> cpu architecture.

Good point. We should add one choice in pci subsystem Kconfig.

Thanks

Yinghai
