Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:33181 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcDSH3N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 03:29:13 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <imunsie@au1.ibm.com>;
	Tue, 19 Apr 2016 17:29:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id F259D2BB0057
	for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 17:28:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3J7Smod4325820
	for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 17:28:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3J7SN3E031169
	for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 17:28:24 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	benh <benh@kernel.crashing.org>,
	gwshan <gwshan@linux.vnet.ibm.com>,
	linux-pci <linux-pci@vger.kernel.org>, paulus <paulus@samba.org>,
	mikey <mikey@neuling.org>,
	"andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
	bhelgaas <bhelgaas@google.com>,
	Frederic Barrat <frederic.barrat@fr.ibm.com>,
	"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Subject: Re: [PATCH v5] powerpc/pci: Assign fixed PHB number based on device-tree properties
In-reply-to: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 17:27:57 +1000
Message-Id: <1461050766-sup-136@x230.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for addressing my feedback :)

Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>

