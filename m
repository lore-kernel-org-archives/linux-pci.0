Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDFC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BA321871
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfABBbm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:31:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:58960 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfABBbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 20:31:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 17:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="130743370"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.90])
  by fmsmga002.fm.intel.com with SMTP; 01 Jan 2019 17:31:40 -0800
Received: by ubuntu (sSMTP sendmail emulation); Wed, 02 Jan 2019 09:31:38 +0800
Message-ID: <1546392698.35646.0.camel@intel.com>
Subject: Re: [PATCH v2 0/2] Add Stratix10 PCIe Root Port support
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com
Date:   Wed, 02 Jan 2019 09:31:38 +0800
In-Reply-To: <20181231161523.GF159477@google.com>
References: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
         <20181231161523.GF159477@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2018-12-31 at 10:15 -0600, Bjorn Helgaas wrote:
> On Mon, Dec 31, 2018 at 04:24:51PM +0800, Ley Foon Tan wrote:
> > 
> > Add PCIe Root Port support for Stratix10 device and also update
> "Stratix10" is a big step better than "StratixXX" because a web
> search
> for the latter finds nothing, while the former does find useful
> things.
> 
> Intel materials on the web seem to use "Stratix 10".  You might as
> well include the space in English text.
Okay, will change to Stratix 10.

Regards
Ley Foon
