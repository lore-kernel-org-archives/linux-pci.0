Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46653 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2AYVbX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2012 16:31:23 -0500
Received: by wgbed3 with SMTP id ed3so5767114wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Jan 2012 13:31:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Jan 2012 14:31:02 -0700
Message-ID: <CAErSpo6Uibvc61AkXDz5qCO3nMH-XNKtGw13fNcr6mAj4hmaNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] add struct pci_host_bridge
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2012 at 5:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This series adds a struct pci_host_bridge to track generic host bridge
> information like the bus numbers and resources available behind the
> host bridge.

Please disregard this series.  Yinghai had some concerns and has
posted other patches to address this problem.
