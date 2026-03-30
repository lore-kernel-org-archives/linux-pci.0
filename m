Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE536404D
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852365; cv=none; b=o5mLq8nfntzOl60W2h6qsbdFMj8nJVNsDLkrFz1p0oAIyuncj/OpOe22LBiMX10t5YW2vM56qGdzq8G6zS8Ee6NcXZQhrQtiGbVQrl0nphSKTef9ml/1XjFudfWDphs0+Bey+3nDEcJ8ZqzQ25jKH4Mu71S6nv2QLhsRXeFyvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852365; c=relaxed/simple;
	bh=xEwmlZq3D6O8mgk3EElXlb8le3nX0/6C57zHo/hfV/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+odUGv0PyI4p58BfokGpEEkMppmyI0gsZyG99gsm/I/DAjmK76FRY1ReqP1vNJdMgkUk4Aope4uDnQ7j80dC/4GPOKhl1YqujOASouAlIFR5GV/AqCHRXqyPgEZHC7+08MRhV3lLiclL6L/pfJiUMfLyzjd13hELtWpwhKbxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lCsFoY2/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lCsFoY2/"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fkhHz2S4Yz9twV;
	Mon, 30 Mar 2026 08:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774852351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ECkB4mOSlmWvMXRknxyN+wK1aHs3Stn2HSImKd9F8=;
	b=lCsFoY2/dNW6hlSHuK7yrDdFgJBAKkCBvgX74WSUhyc+5kgVUWl7kBqUbI5TvPHeouHGeT
	XLBkKF9ngRc+6pC0IobwsLhrm2BT7C0JvRzgCFFVvMKDp7aGqOtOxaz3U9NPRtcO4XwLi+
	2ScXEKq9Y2xs99qt+UQBcmpThi3H++Q003MlIkgv0hrIBr5uNwcRa/y2pGGjP90Mk2QpRg
	vml7y3sR91XtyTvUUZuBF/sjhKxtKUB9x4p49JxuXhWFJTZP3GdHxwkFHeVbblSuKT5pJW
	nUP6gGP4v8MnjCTgtbQjqjEPgTN6bX277z9/n+CXPTUde1kS6/mlA1oUYzR4OA==
Message-ID: <e2b13d94-3f0c-4c2f-87b9-209f1ac04f23@mailbox.org>
Date: Mon, 30 Mar 2026 08:32:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI/AER: Stop ruling out unbound devices as error source
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0d1365e5608b1ab5bd3
X-MBO-RS-META: kz7zti7iux89zom9i7139ty3r94syf3m

On 3/27/26 10:56, Lukas Wunner wrote:
> When searching for the error source, the AER driver rules out devices
> whose enable_cnt is zero.  This was introduced in 2009 by commit
> 28eb27cf0839 ("PCI AER: support invalid error source IDs") without
> providing a rationale.
> 
> Drivers typically call pci_enable_device() on probe, hence the enable_cnt
> check essentially filters out unbound devices.  At the time of the commit,
> drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
> and so any AER-enabled device could be assumed to be bound to a driver.
> The check thus made sense because it allowed skipping config space
> accesses to devices which were known not to be the error source.
> 
> But since 2022, AER is universally enabled on all devices when they are
> enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
> AER is native").
> 
> Errors may very well be reported by unbound devices, e.g. due to link
> instability.  By ruling them out as error source, errors reported by them
> are neither logged nor cleared.  When they do get bound and another error
> occurs, the earlier error is reported together with the new error, which
> may confuse users.  Stop doing so.
> 
> Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>   drivers/pci/pcie/aer.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4299c55..384d026 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1039,8 +1039,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>   	 *      3) There are multiple errors and prior ID comparing fails;
>   	 * We check AER status registers to find possible reporter.
>   	 */
> -	if (atomic_read(&dev->enable_cnt) == 0)
> -		return false;

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

