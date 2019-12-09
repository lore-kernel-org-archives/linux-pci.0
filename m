Return-Path: <SRS0=OOKX=Z7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFDC43603
	for <linux-pci@archiver.kernel.org>; Mon,  9 Dec 2019 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A594206D5
	for <linux-pci@archiver.kernel.org>; Mon,  9 Dec 2019 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575926161;
	bh=9iHR0ajRnJxO+Uw4M+k9lqndy9j5D0Kb4OKxkFeJEvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=xju8HHofe8DFajNN12OEifUs5E7Vj475ako9XktQIpNxZIwjBsxC1BlS8GD80To4C
	 B99RAdFcvgL3dB6tPmQf280NcgmlNOzVU55fkPuJlkwdqye75hjdgI2CTv+aqVXo2d
	 yJCUaluZLk/baFcsbZH15qCmCkyQqSxEkx9zCZEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfLIVP5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfLIVP5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 16:15:57 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2539E206D5;
        Mon,  9 Dec 2019 21:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575926156;
        bh=9iHR0ajRnJxO+Uw4M+k9lqndy9j5D0Kb4OKxkFeJEvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cs6Y+ZzYcYvWBo3EjZvgj2iG4P1jzXx0C+HWCH2wjYA6OMzuJ9MbCN7EVmp5v+JGo
         JVLOV5esOjEG4B0WEV7YHWOsWGRtq3gZyvlGOuWooPyPVzkv4GfyzTyRKZ/P6hAEW9
         yIqwiYXuZVRJJsXjAktiII3G2Pfbyyu0vB19kj+0=
Date:   Mon, 9 Dec 2019 15:15:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
Message-ID: <20191209211554.GA217130@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-6-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
> Certain platforms like TI's J721E allow only 32-bit register accesses.
> Add read and write accessors to perform only 32-bit accesses in order to
> support platfroms like TI's J721E.

s/platfroms/platforms/
