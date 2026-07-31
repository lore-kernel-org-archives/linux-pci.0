Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03440F72B;
	Fri, 31 Jul 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493056; cv=none; b=MNN5QA4vYphnVGZc4YjtoZ6OgPVGMu+qicE4athphONETMO60TpMXiT0p6m+XMA2benYYB8Jj/BlIdx5W2G8W/nbpA888yKc/QmnI6whjcuCrrsrKcaUrqch3cKj6V2o5cHTDT5mW7GaZ/mSFgmpwBX+VCxIRgce1lwQMReiQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493056; c=relaxed/simple;
	bh=ryUIrfwLhwmOaFyadnky7X8MCgTqNwrP15Ps6HbJRew=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HrNL3n3q+FAYcrbtnYCU/JRewm4ku9E+3TvU8MHxSyflhdc0rnLnTYUi+J0o/6G6DbZq3/M1jCFuaFqnmtDRCjkSmZK6OobxTQTXKJuh2NPGJxo6eSrlq6sMQNYSi5UG1mlG+QeqzeoWsAobTei+hHlvFXvXajRB32J80FZo70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=IVW8HFTb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcAf9nM/; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="IVW8HFTb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EcAf9nM/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D43F9130007B;
	Fri, 31 Jul 2026 06:17:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 06:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785493037;
	 x=1785496637; bh=GK3P8P19kG8dXqY7osPQDP/iPoqGbBmtaXA7tO2dwhk=; b=
	IVW8HFTbbVEeFIw4IKo/saEqH8ptOlB1vDBuvZp6QQcinyktarELLiXP02UB5ZSc
	dRfZOM9CseWYhlYsMYEtpLrdGzoS2Ci2O+3fJBTj6B3oKsT3DV1nselK77aKZZ/M
	lsoabYUm9oFf2ucYTE76IGweptLHuRsYXVUvOBV7PJqPFI2wnlfZuEzsdbSmDHc8
	U/0XzzWNzbyG+4U3w50E1kMDdFTJ8G2LkSCjDI2fq0WwXzSw/7TUM+WHjY+5SZQ0
	PkvsHb6FD+4uyx+jMTTd+DbtPIlUNpN1gUceKb+463oznUfBhSvKHMZuW8s4YJnO
	Gs/J3tANeahs3hd5ntD9zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785493037; x=
	1785496637; bh=GK3P8P19kG8dXqY7osPQDP/iPoqGbBmtaXA7tO2dwhk=; b=E
	cAf9nM/mr49QV3OsKrZes0K1n8ngTKGd7Lxc7mEcQHCKJMeYtJOupDFh7C2A4uzF
	e2NX5xzsrCiGMlM3Qq+VMA0qyywz0ltMWDoePQ9SiIgnXfb0w9w/q7Jfu7CHrl5u
	v3SOXl+Vg6xdzO+sBbKvV1MBaf+NMT1mZu80nKSAgfDocOPjenzif1GXDqrqlI+x
	5PSQbMDzulOIVUdAjdfriV2s9YPr0wN6yh5UN5LtQ3RUvWQaEseD16Bh1/bNdm8i
	dV/dgGtYcT1KZusEsx7yW+xek2Esme0cfD6jgbG2155nipWjBB9ylY2y6bbnOXRW
	S1Obl0gmiRgzKu5Qwwaog==
X-ME-Sender: <xms:LHZsauShn8mGFCBuzq4_3YtOHd463pJuoe67EelvbJPVY2G1uMlmsA>
    <xme:LHZsat_EgCrb3ej7iUCs4U1KllQMytjiHTNl5bKTcAfZbB3wVk9MTLm8pANNXkvJh
    2I6vVKbOPMqZRTlWu7Mu6QzeHW7DzQV_DL5yUR4XwbAUgQ2x_zYWGk>
X-ME-Received: <xmr:LHZsagdLKjIoDE1t5h_c7McrnjAesBaTDcOfF_3W7yuNmT4yE1ngt7rw6Mo7oqV7kcy2o6yPsV1ft0xyleTfcOtW>
X-ME-Proxy-Cause: dmFkZTGxdK/tDV8VBNof2Hwu53b8KvHPCYjs9XaeFidCuyISaxjRqGVq+n3C7bA9+5sHpb
    LCVWu1bA2cgrHl+YI5p2wukXY79TwzXEfH0aQVSK+ECk31Mx/Qut1UhvX14kTvB0cat/9F
    klapUXPtOnJXJy80ECRgMDUxqUYtLXv0GQZiElMq8mOdIFjlyYg1HipJwZ6E91jPe1EJZe
    xR9APzJgxE+KWIpFKucjXA76vslaUWLYenUcUOJf0Uf92d05S8XhlqgTXqrzXn76b5/7yG
    Yq2yZmBObo3AXVSwn2b08Bq/2OQPrE2OkQ3HOdn1TfL5WmeoAByXUC3SrdK3HdgCJNojBu
    D34tKBwU0vdLVRDubLweHmqH0xaE8BLVk7w6XxyF5aeaKXCNss4RmSqanPKFCqEsPuHZ53
    yLyqzrwUZz8yDiSDZLbNEmFUaM+nhag/lnVfHPFl3h3wdnUUlk0tJjUUEO+xXh5y+EQpgq
    xjb1uhEe5BEVD0n2Cty22Xq/R090ZFTqFxhoodpUALfQbT7Ng14rtFYXWVVz6zX582m9zJ
    t2IB2MQDXayKiEfBCHfy9W7RLS4aEt8HndKwHnN8iW7SHWFren+5qHQVGXSCslkyEc5Oc/
    CMLxSiTdXHGP3Am2+ziJksV4aCMbllhTNA5ai2YGfGb/8N5cbR8Y0S/R7Ppg
X-ME-Proxy: <xmx:LHZsaqnEO53AFzAEMmVwAew5Js5b4uh-Gs6pngewQIFPEYsbYA6OgQ>
    <xmx:LHZsarzXJSD6C5JAG86e7rj2TO0DsuQmMGKauAUWRPgPy27L3KH1gw>
    <xmx:LHZsaqjMHrFZZ0tDEJr20PuwzSv_LQxCqtiZEMd-sodWdnSc3nL3qQ>
    <xmx:LHZsaqCS40YyiCR9tcWAf8XngC43cHCkPDBLsRu4-2OjGN8j6bUZkw>
    <xmx:LXZsatpdL4STtOM5NbrYjkX2mgbV-eFXCZ-uRmFTDolsykFW1gpTjVLL>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 06:17:06 -0400 (EDT)
Date: Fri, 31 Jul 2026 19:17:02 +0900 (JST)
Message-Id: <20260731.191702.2195123016093141361.tomo@flapping.org>
To: gary@garyguo.net
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, fujita.tomonori@gmail.com,
 airlied@gmail.com, simona@ffwll.ch, bhelgaas@google.com,
 kwilczynski@kernel.org, abdiel.janulgue@gmail.com, robin.murphy@arm.com,
 david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org,
 lenb@kernel.org, igor.korotin@linux.dev, robh@kernel.org,
 saravanak@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 fustini@kernel.org, guoren@kernel.org, wefu@redhat.com,
 ukleinek@kernel.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 05/11] rust: net/phy: remove expansion from doc
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
	<20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 13:39:39 +0100
Gary Guo <gary@garyguo.net> wrote:

> The expansion serves little purpose and it can easily diverge.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/net/phy.rs | 56 --------------------------------------------------
>  1 file changed, 56 deletions(-)

Agreed, it has already diverged, so let's drop it.

Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
