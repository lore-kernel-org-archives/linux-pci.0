Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:61087 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbaB0OJl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 09:09:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-kernel@lists.linaro.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
Date: Thu, 27 Feb 2014 15:09:28 +0100
Message-ID: <5331963.VjH27eqhpK@wuerfel>
In-Reply-To: <1393506599-11561-2-git-send-email-Liviu.Dudau@arm.com>
References: <1393506599-11561-1-git-send-email-Liviu.Dudau@arm.com> <1393506599-11561-2-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 February 2014 13:09:57 Liviu Dudau wrote:
> The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
> is wrong. It returns a mapped (i.e. virtual) address that can start from
> zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
> architectures that use !CONFIG_GENERIC_MAP define.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
