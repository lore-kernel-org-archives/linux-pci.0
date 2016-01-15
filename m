Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35425 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcAOOLM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 09:11:12 -0500
Subject: Re: [PATCHv2 0/4] PCI VPD access fixes
To: "Seymour, Shane M" <shane.seymour@hpe.com>,
	Hannes Reinecke <hare@suse.de>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
 <DDB9C85B850785449757F9914A034FCB4450CEC7@G9W0766.americas.hpqcorp.net>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <5698FDF1.1060601@oracle.com>
Date: Fri, 15 Jan 2016 08:10:57 -0600
MIME-Version: 1.0
In-Reply-To: <DDB9C85B850785449757F9914A034FCB4450CEC7@G9W0766.americas.hpqcorp.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Shane, Thank You very much..

On 1/14/2016 7:07 PM, Seymour, Shane M wrote:
> For the series. Tested with AE311 PCI-Express 4Gb Fibre Channel HBA.
> Truncation of the vpd data returned works (154 bytes) and lspci -vvv
> prints out the VPD tags the same way with and without the changes.
> This card did not require any quirks it was capable of returning 32k
> of data (although it repeated every 4k).
> ---
> Tested-by: Shane Seymour <shane.seymour@hpe.com>
> 
