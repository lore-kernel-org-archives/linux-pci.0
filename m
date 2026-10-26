Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001197;
	b=QY9dHRT8gt34oZ9VocAHua6Wzf/3beAmU1vq4ZHlBTmMul1Q0nAHGszG1g7DjG7zRPmc
	 PbLoe8QEBi/ucb9PSfAozuY9tKegUSszun3EC29Zjq9jkI8syp0rVNOXme41dLSceUH8d
	 H7+znSQ2wd8ZWaLbIKbGMDOFDafIIab8FFXGVqKYzEaPoQZknjmaqNWUYakW0oic0Ygfo
	 ybxKd/K0sJQRT93r8AX1A5hx4Kk/wAJU/XsQyf6q3jibcOlHzOrXJL8WC4U0h2Vsc2Lrm
	 v6fIqY1Ll+x4/6s2ZT2Vff4e62O6gcsVZSROYdf/AxNfioEEDXXXAi8m4V5SWolyJbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=0qw5HqjCC5zdFEPhrGxqWLo+k92+fiCBMMJ19xH2DEQ=;
	b=RMSCsKyZBPFgDHg16oznlLpqNDhDyzou1TMxOIJrzYx1FpvEcz+cUZugynUU2O5mETHY
	 d7ucV+QZOXT8BWOI0sH6RmWJ7JTSEIR/TfIPl9+ez+F7XM8gmikawgwFAVBRRzxCvQ1fX
	 mCxoX34RRP8BMaeuCc7Gh+aKYz9Yzc7nbSxjwQrocE2HElvGxuM23NnGkHO4AfFjHszV1
	 duIZzl3xC2MwCVEIItD8+9vLgxp6L+UsLLrmaQL9j6mYZJYWrEReUOtwnlRyu3gznCrew
	 XDKf/mbbA/GuMzRsnIF9ReWraV+Z3nBy6OwkpqJVdvkHXPsY6fyOkti3RpZyLrTfZqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0W5OmGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221460A2629;
	Mon, 26 Oct 2026 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0W5OmGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EAB1F01825;
	Mon, 26 Oct 2026 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793001197;
	bh=0qw5HqjCC5zdFEPhrGxqWLo+k92+fiCBMMJ19xH2DEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0W5OmGj345e4icryfA6fmnT8OgSJcIR8OQam9Wmi8BjCF3R/kxzOMZDEEBp9woD2
	 6Bti1BCAESy0yW0J10ko/4lcrjCk07Tpa5Hixfha3SmHATic55UY5l2yenHih385bJ
	 HsNaHX/lZKesxTZfZ9PUa2ZliBh0B/sufpncUaoXdmUXLVja1ajQYgr2gefUfstMb5
	 lSnSDm++Ronw+1HC3Ias/9pBNpTmf0+ttRoO9n/t85wQfRFlWHE8YVuVjzxhnFuDmw
	 MeVOQ3mFIIJUZMpoF/r/CIOOFVK6TtDEkviQmq7NG6vuOJeY2vOXXGgwcNnD/FYDx/
	 F1m2ljTC0lyGg==
Date: Mon, 26 Oct 2026 13:23:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anthony Ruhier <aruhier@mailbox.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to
 allow ASPM L1.2
Message-ID: <at8GgTHUjOF8Tv1J@debian>
References: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
 <20261023182004.GA2796729@bhelgaas>
 <atvQtV71SbtMK-jZ@tour-anthony.aruhier.fr>
 <at7x8K9Xxa92xW2j@debian>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <at7x8K9Xxa92xW2j@debian>

On Mon, Oct 26, 2026 at 12:55:25PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 23, 2026 at 11:49:22PM +0200, Anthony Ruhier wrote:
> > On Fri, Oct 23, 2026 at 01:20:04PM -0500, Bjorn Helgaas wrote:
> > > By "firmware reports LTR value", do you mean that the WCN7850 sends an
> > > LTR Message with snooped/non-snooped values just below
> > > LTR_L1.2_THRESHOLD?
> > >
> > > And since the reported LTR values are never greater than or equal to
> > > LTR_L1.2_THRESHOLD, the link never enters L1.2?
> > 
> 
> This is correct.
> 
> > Not exactly. The firmware doesn't report a max snoop/no snoop that I could see
> > in lspci (it's set at 0ns), but if I set one with setpci, the card still
> > doesn't reach L1.2.
> 
> Max Snoop/No-Snoop latencies are supposed to be set by the host software, not
> the Endpoint firmware. The Endpoint firmware only uses these values to send
> their Snoop/No-Snoop latencies in the LTR message.
> 
> But there are two issues here in Qcom platforms:
> 
> 1. Neither the BIOS, nor the PCI core/pcie-qcom driver set the Max
> Snoop/No-Snoop latencies for the Endpoints/Upstream Ports based on the platform
> requirement.
> 
> 2. The L1_2_Threshold calculated by the PCI core doesn't match the Qcom platforms:
> 
> l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> 
> On the Qcom platforms, T_POWER_ON is 0 by default. I initially misunderstood
> that the T_POWER_ON value of '0' was wrong. But after checking more, I
> understood that '0' was indeed the correct value, but there is one more
> parameter that we are not taking into account, which is TL10_REFCLK_ON time. It
> is ~40-80us depending on the platform.
> 
> Unfortunately, PCIe base spec didn't define any registers to pass the
> TL10_REFCLK_ON time to the OS. I'm planning to introduce a DT property, set
> it in Root Port node and take it account in the l1_2_threshold calculation.
> 
> Because of the issue (1), the Endpoint firmware reports 0 Snoop/No-Snoop
> latencies as the LTR latencies cannot exceed Max Snoop/No-Snoop latencies set
> by the host software. This is the behavior across all Endpoints connected to
> the Qcom host machines.
> 
> So if the LTR requirement bit is set, and the Endpoint sends 0 latencies in LTR
> message, then L1.2 is not entered all the time because, LTR > L1_2_Threshold.
> The spec mandates that the link should enter L1.2 only if LTR <= L1_2_Threshold.

Typo here. I got the condition inverted. Currently, LTR < L1_2_Threshold and
spec mandates LTR >= L1_2_Threshold for entering L1.2.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
