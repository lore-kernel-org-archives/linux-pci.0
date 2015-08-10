Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34467 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbbHJWHO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 18:07:14 -0400
Received: by igui7 with SMTP id i7so28433494igu.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 15:07:13 -0700 (PDT)
Received: from google.com ([2620:0:1007:b:254d:7b22:9adf:e278])
        by smtp.gmail.com with ESMTPSA id vk8sm6745738igb.4.2015.08.10.15.07.11
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 15:07:12 -0700 (PDT)
Date: Mon, 10 Aug 2015 17:07:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: pciehp: Remove unused interrupt stuff
Message-ID: <20150810220709.GB13982@google.com>
References: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 04, 2015 at 06:59:09PM -0500, Bjorn Helgaas wrote:
> These are pretty trivial; they just remove some unused interrupt things.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: pciehp: Remove unused interrupt events
>       PCI: pciehp: Remove ignored MRL sensor interrupt events

I applied these to pci/hotplug for v4.3.
