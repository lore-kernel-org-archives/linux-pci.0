Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34717 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbcD1Vfv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 17:35:51 -0400
MIME-Version: 1.0
In-Reply-To: <1461878858-23798-1-git-send-email-cov@codeaurora.org>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
	<1461878858-23798-1-git-send-email-cov@codeaurora.org>
Date: Thu, 28 Apr 2016 23:35:49 +0200
Message-ID: <CAJZ5v0jrwmPTQHHrVCd_ysVwWdfiwo3041ez60o-j+gmEC_cjA@mail.gmail.com>
Subject: Re: [PATCH] acpi: pci: QDF2432 32 bit config space accessors
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	Mark Salter <msalter@redhat.com>,
	Mark Langsdorf <mlangsdo@redhat.com>,
	Jon Masters <jcm@redhat.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 11:27 PM, Christopher Covington
<cov@codeaurora.org> wrote:
> Qualcomm Technologies QDF2432 SoCs require 32 bit accessors to be used
> for the PCI configuration space. Register the appropriate quirk.
>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> Depends on Tomasz Nowicki's latest series:
> [PATCH V6 00/13] Support for generic ACPI based PCI host controller

Please send this when the above patch has been put into linux-next at least.

Sending it earlier doesn't serve any purpose and is adding to noise.

Thanks,
Rafael
