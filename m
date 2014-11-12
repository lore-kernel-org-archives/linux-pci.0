Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:53900 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbaKLCsH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 21:48:07 -0500
Received: by mail-qa0-f43.google.com with SMTP id j7so7890467qaq.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 18:48:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACVXFVPzo2qNGa5DWESS3TXor=u82_SxHb+xzrBCRXtcQxq4Cg@mail.gmail.com>
References: <1415702040-2790-1-git-send-email-ming.lei@canonical.com>
 <20141111122901.GA4419@red-moon> <CACVXFVNAc9axtESmo1zGZ3GMquTzjzWR3jx-b3tbhhLfQDDRcg@mail.gmail.com>
 <20141111182418.GA5507@red-moon> <CACVXFVPzo2qNGa5DWESS3TXor=u82_SxHb+xzrBCRXtcQxq4Cg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Nov 2014 19:47:46 -0700
Message-ID: <CAErSpo5LELkH=9WAq5MDE6fkVJvPK3miQtqrMnRHY7QyLWigUg@mail.gmail.com>
Subject: Re: [PATCH] pci: generic host: make it more generic
To: Ming Lei <ming.lei@canonical.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	alvise rigo <a.rigo@virtualopensystems.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 11, 2014 at 7:12 PM, Ming Lei <ming.lei@canonical.com> wrote:
> ...
> Do you think it is doable to introduce a option(from module
> parameter, or device tree, ...) to let the driver and PCI core
> ignore/bypass all pcibios handling for the generic bus?

No, I don't think so.
