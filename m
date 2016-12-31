Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:49050 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbcLaPeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Dec 2016 10:34:03 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id BDC251C00B8
        for <linux-pci@vger.kernel.org>; Sat, 31 Dec 2016 16:28:34 +0100 (CET)
Date: Sat, 31 Dec 2016 16:28:34 +0100
From: Martin Mares <mj@ucw.cz>
To: Satanand Burla <satananda.burla@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pciutils: Add decode for Atomic Ops in lspci
Message-ID: <mj+md-20161231.152720.17786.albireo@ucw.cz>
References: <1482882756-12151-1-git-send-email-satananda.burla@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482882756-12151-1-git-send-email-satananda.burla@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> This adds support for decoding Atomic ops added in ECN
> https://pcisig.com/sites/default/files/specification_documents/ECN_Atomic_Ops_080417.pdf

This is much better, however, it still prints extra spaces sometimes.
Could you please fix it?

Also, I woule like to have a test case for the new code -- a configuration
space dump similar to those in tests/*. Do you have one?

				Martin
