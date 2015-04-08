Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35317 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbbDHVc0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 17:32:26 -0400
Received: by obbfy7 with SMTP id fy7so159863679obb.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2015 14:32:25 -0700 (PDT)
Date: Wed, 8 Apr 2015 16:32:22 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] PCI / ACPI: PCI delay optimization from ACPI
Message-ID: <20150408213222.GF30967@google.com>
References: <54FD4FB9.2060802@intel.com>
 <55125611.8040507@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55125611.8040507@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 25, 2015 at 02:30:41PM +0800, Aaron Lu wrote:
> Here is v3, changes from v2 are:
> - Patch 1/3: add Rafael's acked-by tag;
> - Patch 2/3: newly introduced, to rename find_pci_host_bridge and export it
> - Patch 3/3: address Bjorn's comments for v2

Applied to pci/misc for v4.1, thanks!
