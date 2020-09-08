Return-Path: <SRS0=qE/B=CR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50DCC43461
	for <linux-pci@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972C520768
	for <linux-pci@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594828;
	bh=itBM8Pz+g8q2N8uR1HK1nQyN8yQuwR0sJ8EdMBH5FQU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=imeGANPnUDNt3oV1k0YfHcDWpuDuSDpaamwjupTEnZzVc+/jOR1Pchp0YfnBt+t6R
	 FqsVxC9zHU5QsRdrVZhfteNDx6x3OJjg97vzu+ufFF8h7Rh2qhvkVRmiPRg6/BB5Sx
	 5GbURRmHxgeOLGZZb+JhGcXVCIPW/xKFbxzB7vkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgIHTxq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbgIHTxp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 15:53:45 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E53F20768;
        Tue,  8 Sep 2020 19:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599594824;
        bh=itBM8Pz+g8q2N8uR1HK1nQyN8yQuwR0sJ8EdMBH5FQU=;
        h=Date:From:To:Cc:Subject:From;
        b=P+hL7vhBXbx7ms2dsfLzffHZulogMSRy4c72sL6uTqTKFlvh1VsTa6oK9JqIJGbp2
         5UFAgJEDcqlZNUX/SAcvzMVK9q2Ww6zilMauUOYCcny+aWchaB/2VxAjv9aH+6d4X8
         LRUHEgpvt3ymnUEw7fiQJOlcyAf1EigJWmzUkMFA=
Date:   Tue, 8 Sep 2020 14:53:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: pcie-designware.c sparse warning
Message-ID: <20200908195343.GA627554@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI, got the following warning from "make C=2 drivers/pci/":

  CHECK   drivers/pci/controller/dwc/pcie-designware.c
drivers/pci/controller/dwc/pcie-designware.c:432:52: warning: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)

This is on my "next" branch.
