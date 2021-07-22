Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBCC4338F
	for <linux-pci@archiver.kernel.org>; Thu, 22 Jul 2021 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B31C60EB4
	for <linux-pci@archiver.kernel.org>; Thu, 22 Jul 2021 21:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhGVVGY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVGX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 17:06:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9EF060EB5;
        Thu, 22 Jul 2021 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990418;
        bh=cV/4JffeZ0wOrvxP7tAjop1Uq8I72VbWMErQH53LBdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jrrrE1RuESqz2MN+TOZ+mcMj3KhcerJAhDELjM8cXKiuHJVxt5mS3/nKl+5As9dx9
         7vY0w0so/Gh/tzY5kaRlhIPeRQ7mq8W1m04ZyGBB9ZqWKa4yYwTsEHp3tIt3Exq0Pl
         gRktzP7NfEsYgA97rY6uqvxC067Hweph2CxxUh717+crtnpsTEYl62StjyICQeyiNx
         VYEyIbWcuFQAgWhWLuK67iNLxzvQ3sI4sHqEZfEgBeeIGHx5GWxNE0/U+vhPw5QPFB
         LvZAsQDY1Kl8y+8SVqRNROq0wr7uiSFnHKJbMgPiZ9ad+Yv8QCdc5lshG2hi/4D9sB
         Otmn8hIH/BtOQ==
Date:   Thu, 22 Jul 2021 16:46:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 3/8] PCI/MSI: Enforce that MSI-X table entry is masked
 for update
Message-ID: <20210722214656.GA350054@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.408910288@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:29PM +0200, Thomas Gleixner wrote:
> The specification states:

Maybe add "(PCIe r5.0, sec 6.1.4.5)"

>     For MSI-X, a function is permitted to cache Address and Data values
>     from unmasked MSI-X Table entries. However, anytime software unmasks a
>     currently masked MSI-X Table entry either by clearing its Mask bit or
>     by clearing the Function Mask bit, the function must update any Address
>     or Data values that it cached from that entry. If software changes the
>     Address or Data value of an entry while the entry is unmasked, the
>     result is undefined.
