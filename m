Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7349 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab3H0WFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Aug 2013 18:05:54 -0400
Date: Wed, 28 Aug 2013 00:05:51 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] PCI: Rename PCIe capability definitions to follow
 convention
Message-ID: <20130827220551.GD20329@zurbaran>
References: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
 <20130827190025.16595.84911.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130827190025.16595.84911.stgit@bhelgaas-glaptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Aug 27, 2013 at 01:00:25PM -0600, Bjorn Helgaas wrote:
> All other PCIe capability register fields include "PCI_EXP" + <reg-name> +
> <field-name>.  This renames PCI_EXP_OBFF_MASK, PCI_EXP_IDO_REQ_EN,
> PCI_EXP_LTR_EN, and related fields using the same convention.
> No functional change.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
For the MFD driver:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
