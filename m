Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B1CC433ED
	for <linux-pci@archiver.kernel.org>; Sat,  1 May 2021 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5D61409
	for <linux-pci@archiver.kernel.org>; Sat,  1 May 2021 08:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhEAIjH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 May 2021 04:39:07 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54075 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAIjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 May 2021 04:39:07 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id ADE2A2800B3D2;
        Sat,  1 May 2021 10:38:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8FE821908; Sat,  1 May 2021 10:38:16 +0200 (CEST)
Date:   Sat, 1 May 2021 10:38:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210501083816.GA29239@wunner.de>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 01, 2021 at 10:29:00AM +0200, Lukas Wunner wrote:
> Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> link upon an error and attempts to re-enable it when instructed by the
> DPC driver.
[...]

Sorry, forgot to include the changelog v1 -> v2:

* Raise timeout for DPC completion from 3 sec to 4 sec (Yicong Yang)

* Amend commit message to clarify that the timeout is not taken from
  the spec but rather based on reports (Yicong Yang, Ethan Zhao)
