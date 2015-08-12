Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33761 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbbHLO5c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 10:57:32 -0400
Received: by lalv9 with SMTP id v9so10616320lal.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2015 07:57:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439372036-15303-2-git-send-email-l.stach@pengutronix.de>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
	<1439372036-15303-2-git-send-email-l.stach@pengutronix.de>
Date: Wed, 12 Aug 2015 20:27:30 +0530
Message-ID: <CAHM4w1mCj_ZrS+5MZNZeuPWjQ6KfyVXz2AiaDntoogTpKCQBSA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PCI: allow MSI chip providers to implement their
 own multivector MSI setup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 12, 2015 at 3:03 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks fine to me.

Reviewed-by: Pratyush Anand <pratyush.anand@gmail.com>
