Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889820;
	b=u18ZhkgHYcprxAmlVzay2LqkMHYRvbucAng4++I02+tkV6e5PuBP1WJ458nd1Egi3vIe
	 6544M5Re4icFDVINOy0+hMtggAkekHm/WHd4KeeBLMIIks5GBZRbdrWW/us57hDOQjQOS
	 xU2l19MHUIwUE8wATCAdPNvlRuVqq4uW/rsyHVUwEXcLCZu8lkOhYcgkYs/luglW8REBr
	 /7HCfIWw+G5udWDdffACiBSrIb9nS8U05+Ba/2EDicHAOYndH3oyVqyroAitUIsrHxzIy
	 tPyLH40Ih6xcOGyFkpZIsJBLXNEKEtVazNNQR2xP9P4noqLXy5VKTIAQYe1uvxzS6Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M70OQDuXK+abJGMUE43Gfl7rDaTxBy+PUpescgSqPPw=;
	b=3f3HyN6zHX97uyt0cAlWwxfvsIDlVosGoS/gmoWelc0JLWciH8J7S1mRbC5VYc/fmQTR
	 kHB4/DAmdM7e3XeICWssV9tZl5rVv27vh5MAlJCpDMpt6EThDlFpXBYRqog+bdvpGQaaZ
	 RiM/7pO3a3BlXaasROCk8alQRqH964biJWV5fUbU6Ovob9Ro/+LM8ZNn9+0ILUW9KYkQf
	 jqKuMpA9iTbZuCPnX1jfpXFDkkQ2ocfok1D+6rMgQW5x26iwfo6B53DD+w/1drs3WCDMs
	 5/32pU87L5OU7I3y2LxIwZKYqz8V4jxf0jnjatZfzoZT3k65SAB/TP7gUztrmHu20Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSC+QDU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 72F63606A31B;
	Thu,  5 Nov 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSC+QDU8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C2651F000C1;
	Thu,  5 Nov 2026 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889820;
	bh=M70OQDuXK+abJGMUE43Gfl7rDaTxBy+PUpescgSqPPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSC+QDU8YghkJtFS0cLl+FXR5kGvQmGksdDxWEQD6tFm97MuGJ1pn3ZS7pG/7rLVS
	 5jfIYUpob8t1hHTzVtyYSby95FQO29OVXYfTzIMrOuD3KN/0fe9m/haB3Uo46aND4W
	 m1/VVPWwUVWIBBIi+e16ZhqRqMLI6SkR3ZD07idmuCnQZ8P9igxpDaVAayQIeucoY0
	 icUwZGifc7WRq4sxRyQfkZwiCzo23WALnKM6o/fJbVaLKrZxWXQjfMYTUyklb98WB2
	 bweb8Q/tlIMxG4AL6XiDGN6J/g39odx88A0eHSsMpqUCAV94v00u9mR9WbMPoLYDEc
	 exE4ROZHXypJQ==
Date: Thu, 5 Nov 2026 15:43:36 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krishna.chundru@oss.qualcomm.com, 
	bartosz.golaszewski@oss.qualcomm.com, deepti.jaggi@oss.qualcomm.com, yadu.mg@oss.qualcomm.com, 
	shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Power on pwrctrl devices for firmware-managed
 hosts
Message-ID: <twprfauh4hgbmmsmeejzpq7d75eqwsd22e26luzjix27ygtybr@nnxrapllp6fn>
References: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
 <auyUXp1Fgk2yC7fZ@debian>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auyUXp1Fgk2yC7fZ@debian>

On Thu, Nov 05, 2026 at 08:07:18PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 05, 2026 at 06:15:21PM +0800, Zhangfei Gao wrote:
> > commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
> > on/off, destroy APIs") switched PCI pwrctrl users to explicit create and
> > power control APIs, but only added the calls to the regular DesignWare
> > host initialization path.
> > 
> > Firmware-managed hosts bypass that path and probe the ECAM host bridge
> > directly. Endpoints already powered by firmware, such as NVMe devices,
> > remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
> > such as WCN7850, remain powered off and cannot be discovered.
> > 
> 
> NACK. For FW initialized platforms, FW should power on the Endpoints before
> booting Linux.
>

Ah, sorry for the earlier tag. I should have known this and pointed it
out.

Bart
