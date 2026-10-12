Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6C3890F3;
	Mon, 12 Oct 2026 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819211; cv=none; b=WNyICH7CaKjUOO0I58t4tsMxH09Gq1cwczRK6K0x25fl1N/2imU7A0mPAzn7PpZxzbEXYo7PJ3I9ut1kQcHGszC4TQ/o85H+ec/uxRIrRVFOou+LsZ0Pi10hZqthhaU6m8iHZAkEJBHWGAVrG9KbRMH1/Q0s7wyeMMK3hiZa6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819211; c=relaxed/simple;
	bh=t57b6I0xk2Pn7+DQ16Btcl2KOpcdTiQ/jrSgU6xkWyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fULS+P1iJG2+bTZvz8o9heCyslBVrtPudYPGumV3qjANTuGxLTK07bZ5gw0pXPgbpVEgAOi91ScDP0qVo/RnjK8KD6YNZYgv+ZyZFkP6Jn3DAcIUAuoOs9SnbPp8q+lKIY0rl7qQimZjxiqkG9hmioBRvZfPwSEQn0IFW2hrVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii8RRP9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii8RRP9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35991F0089C;
	Mon, 12 Oct 2026 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819210;
	bh=FVJ3/smLT33iByHGLvW5Yq9/CA9AFPfDNiksjJlTINs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ii8RRP9qwY00Ov0tz8sjKhRlAEbdpQjqvpfEWGyV62fFcDKwGcC5in6mQlTwH/b3W
	 P4CNDRpZkJxeN0Ch6me05bl1QShN40lvSdQBX9eqcB0KbNvLCc5GFC0Zt/lEpvbpQ4
	 oWlqqqt5GZwW8XPHLyjuE+IT4IPLHf0jbb9SBi/DAwz9RzMT6WdnGu2HNq352JZccQ
	 gVXP52ZeamQx0r2zAJjXQ4T+lZniJrzelfrn49o14sOXb+tFXF+uovJoxeLQlx0kYK
	 bIOqhhnKjK7WI6vYUzXNx29wHOV6Qy5iH68h/wQVqgdFANT9Fp4wD2wz6pBKY71Wy8
	 yqNqv6mrgJTcg==
Date: Mon, 12 Oct 2026 21:03:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, sashiko-reviews@lists.linux.dev
Cc: olteanv@gmail.com, vkoul@kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, neil.armstrong@linaro.org
Subject: Re: [PATCH 4/4] phy: qcom-qmp-pcie: Split phy_ops into
 init/exit/reset/power_on
Message-ID: <asz9pEf2DR3_GpuF@debian>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
 <20260916061703.5F02C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916061703.5F02C1F000FF@smtp.kernel.org>

On Wed, Sep 16, 2026 at 06:17:02AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] phy: qcom-qmp-pcie: nocsr_reset left asserted when skip_init is false

Please take a look at the reported issues.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
