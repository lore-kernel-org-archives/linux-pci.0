Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:35292 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbcDSNbS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 09:31:18 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Tue, 19 Apr 2016 10:31:16 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id B363E1DC006F
	for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 09:31:06 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3JCVA8g29753852
	for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 09:31:10 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
	by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3JDVBJU021168
	for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 10:31:12 -0300
Subject: Re: [PATCH v5] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1461050766-sup-136@x230.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>,
	Frederic Barrat <frederic.barrat@fr.ibm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
	gwshan <gwshan@linux.vnet.ibm.com>, paulus <paulus@samba.org>,
	"andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
	bhelgaas <bhelgaas@google.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5716331E.80207@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 10:31:10 -0300
MIME-Version: 1.0
In-Reply-To: <1461050766-sup-136@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/19/2016 04:27 AM, Ian Munsie wrote:
> Thanks for addressing my feedback :)
>
> Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>

Thanks very much for reviewing Ian =)

Cheers,


Guilherme

