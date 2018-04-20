Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:53860 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeDTIYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Apr 2018 04:24:41 -0400
Date: Fri, 20 Apr 2018 10:24:38 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] lspci: Decode capability names
Message-ID: <mj+md-20180420.082411.94657.nikam@ucw.cz>
References: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> This is a minor update to print the names of several capabilities instead
> of just the hex capability ID.

thanks, applied.

> I'd love it if somebody would implement decoding of the content of these
> capabilities, but I haven't had time to do that.

I would have time, but unfortunately I do not have the specs :(

				Martin
