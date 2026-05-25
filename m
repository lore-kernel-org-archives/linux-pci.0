Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1093F413B
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728132; cv=none; b=o639l64MjYjhxxc1vm5GXKkZucc9f+zk2Pf0M5eUyoNTdpU2abnknAC5ZYxMhnlv8qQ4ajcTCeBh1WqaHOhYdZ4+V6G4eay7MjZevrgkFJT8oNeN1qwZKhIN9yKwMGs51AETRscWoCq4qsVLwe40+Zljbg+CT0pH+dH41Ao0/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728132; c=relaxed/simple;
	bh=YkFbm+/wNq+5LWiO6mPuMdi/9JXfPp40CWUvJSE4Xns=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=qRgKo4zyAp++PsoPva7k7vD/qWJey5cpt8ggVhvk+rERTG0heTLEQFieV8F1kq6dZtd0qslavCzIWIDV+CLcCQTsDlqkzvA38iR9kmzhLJFBdB7rGipuwv+20P4UDxugNMGEMMHmmk5NxYk85eFdhgOx74t3b21OeIX2NV4G4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=AyJJlsf6; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="AyJJlsf6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=YkFbm+/wNq+5LWiO6mPuMdi/9JXfPp40CWUvJSE4Xns=; b=AyJJlsf671Fe/R/pT6h+3nQqlV
	/HcmNdzNFrl6uWN5sxqbec3gFGD25Rnu5Ukpy373Cv83+Zw7IIACHM3Ykicd4ZyBFqLUAFLe2b6vb
	/i3YoEBL7UCDBvAzmUzlu2FkN6D6cvF1dFRqGR2jvUu3C9ROwu3mwfhYgoF6lfo1vmzQVBBAMRsFM
	2K/sqtcDZJGSP28zol/MS/nFPA9IOFX+DQZnLWtnZJjuwrg/ohKaSRhJhZThPTkySl01TYEZ1bpYP
	9W5M+U6dKHjhH3Yrqa74j9uoBeg7cyiQqJGmXDtKuRXJtxSbJtipMJvaJemzEqyG8xlyJkbxMXrVN
	URgx7EzA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wRXyN-00000004t9H-0FXB;
	Mon, 25 May 2026 10:16:11 -0600
Message-ID: <2fe0ca03-626e-44c3-a8e2-560d9b7b3999@deltatee.com>
Date: Mon, 25 May 2026 10:16:09 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pat A <lasoyster@gmail.com>, linux-pci@vger.kernel.org
Cc: kelvin.cao@broadcom.com
References: <CA+jUz5KSBDTgYJVB=wUccrerXdekJ3mV_np8iat4PKDteSGmNg@mail.gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CA+jUz5KSBDTgYJVB=wUccrerXdekJ3mV_np8iat4PKDteSGmNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lasoyster@gmail.com, linux-pci@vger.kernel.org, kelvin.cao@broadcom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: =?UTF-8?Q?Re=3A_PEX88000_=281000=3Ac010/c012=29_management_endpoint?=
 =?UTF-8?Q?_incompatible_with_switchtec_driver_=E2=80=94_die_temp_inaccessib?=
 =?UTF-8?Q?le?=
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Pat,

On 2026-05-24 03:12, Pat A wrote:
> I'm running a system with both a PEX88096 (1000:c012, subsystem a096)
> and PEX88048 (1000:c010, subsystem a048) on an ASUS x570 Board (AM4,
> Ryzen 9 5900X). The switches handle 2 x GPUs and 8× NVMe drives.
The Switchtec driver only supports PCI switches made by Microsemi. The
Broadcom switches are an entirely different product line that has
nothing to do with the Switchtec driver. I suggest you contact Broadcom
for support.

Logan

