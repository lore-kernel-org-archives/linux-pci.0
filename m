Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:36100 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbKLGMz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 01:12:55 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 12 Nov 2015 16:12:52 +1000
Date: Thu, 12 Nov 2015 17:11:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 37/50] powerpc/powernv: Simplify pnv_eeh_reset()
Message-ID: <20151112061148.GA17357@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-38-git-send-email-gwshan@linux.vnet.ibm.com>
 <877flniyz3.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877flniyz3.fsf@gamma.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 12, 2015 at 04:11:12PM +1100, Daniel Axtens wrote:
>> -			rc = opal_pci_reset(phb->opal_id,
>> -					    OPAL_RESET_PHB_ERROR,
>> -					    OPAL_ASSERT_RESET);
>> -			if (rc != OPAL_SUCCESS) {
>> -				pr_warn("%s: Failure %lld clearing "
>> -					"error injection registers\n",
>> -					__func__, rc);
>
>This is very minor, but is there a good reason to change the error
>message from the one above to the one below? I just hesitate to change
>error messages that people might be grepping the source for without a
>good reason.
>

About 3 years ago, I think the error message printed by pr_warn() can't
exceed 80 lines each line. Otherwise, scripts/checkpatch.pl will report
warnings. The error message spans multiple lines to avoid that. However,
that turned to be wrong later. If people searchs the code from the error
or warning message, it'd better to keep it in one line, not in multiple
lines. That's the reason I merged them into one line since I have to
refactor the function. At same time, the message is shortened as "Error"
is shorter than "Failure" and "registers" in original message is meaningless.

>> +		if (rc != OPAL_SUCCESS) {
>> +			pr_warn("%s: Error %lld clearing error injection\n",
>> +				__func__, rc);
>
>Apart from that this looks good, pending me actually testing it :)
>

Thanks :-)

Gavin

>Regards,
>Daniel
>


