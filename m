Return-Path: <SRS0=A4Uv=4X=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D773CC10DCE
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3234208CD
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583502414;
	bh=ofoEWvuz60wMYevmFK5gY3rtPf2eTecFYR0FgcJdPvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p8ckPnj7RtEwPj7gllifw8K7vc4XxX/cl9Xgpjf2XUZjhkTNAr6ID9OS+I3CC02xJ
	 0IHXlGitLsUd5JV+WiUITsOLgZXUXa/wvR4Wib6ARRngFmbcnrtmo1yDK/CJC+AwN0
	 eubzmttik3cAIN3k1khWUfkYe9TeQdod+WCpHVQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFNqy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCFNqy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 08:46:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FCC2084E;
        Fri,  6 Mar 2020 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583502413;
        bh=ofoEWvuz60wMYevmFK5gY3rtPf2eTecFYR0FgcJdPvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J2W7NrrkTWNs3aEPCs3JupR+tZEIA4kk4bn/WYvcq4lgOdmmu8XKeKVIBznD3aCJJ
         oy+loPZTqu0GdB6ZNXPjVmJs3jwunetuH0Lxk5E498bCl4zqRQLd9QwmxtHHmFyVeV
         dDm8SMvBRsmejpki6P/E6A3PxzgRM94ZPNIzZqh0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jADJT-00AaW5-P6; Fri, 06 Mar 2020 13:46:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Mar 2020 13:46:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [patch 5/7] genirq: Sanitize state handling in check_irq_resend()
In-Reply-To: <20200306130623.882129117@linutronix.de>
References: <20200306130341.199467200@linutronix.de>
 <20200306130623.882129117@linutronix.de>
Message-ID: <10cde01e873942d45a9877ea08a77e35@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-03-06 13:03, Thomas Gleixner wrote:
> The code sets IRQS_REPLAY unconditionally whether the resend happens or
> not. That doesn't have bad side effects right now, but inconsistent 
> state
> is always a latent source of problems.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
