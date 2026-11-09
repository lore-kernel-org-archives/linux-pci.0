Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257289;
	b=Ld9uiPwVlJyRgyd9dcHbFm4UFHYH7LSDpt0c1UW22gqTEfVnjY92Aj6C5qrEeURkbOtV
	 SdyoHVhE9p49jKM96FHbAQP5fbhmiEdRu92flySirVbKf2o7xBf+ih4PU91eJKqL1NmE3
	 MMCs60WjgQdDn+GK1FsHWbsM15WRyY3cdD3f+hxkG42QmO4aAj/qvgy1HnDRt9xYQZmAO
	 3TyzOuaJPzkjXvEbXgzWNuk5wYhWFROjhvvn44mnB0qc20U3judu8Npohq34vF6DsmQ64
	 BCMyuiDnFBTuvLua5MUDP8X9kbRWez6N5cMfWQtwk0VMM9tXwq7Ye8Lw3V1MQQApCWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257289;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hAko9zGkmi9niJtZOL71kVVVwwbmLc2t5MHh5r5eE0o=;
	b=HmUl+hmzIIhor4pwwb0ADJaDjXAOaTINeOPNfoytG9+xYQc74p7LNYJ1lOngtYXH2xQd
	 7DideO+1Q5KYIxeDj1je2U1egvKNx6zBPGvc6/xN8KVrT3T8CA24BFtjh1yQ1alsojVAr
	 9Q4ltHtyBqPKoR+4L3zLV/IyWYm5SKL67Jl4ZywB/X6jfaNQlwuYHR3IoflJUUHJVjMMz
	 ouQu1O4cs7TBmm0q4RUNutSIor9QbpJP1IJMqInNIcE5NCdJaQ4cjMlAhjJ9sD0fLlgUJ
	 2o14qFqXVvszWId/A+Jk83gUwj8HH3YgQOXmf4nA9L6WQn5+HNM6OPbAEDiFjb0mA1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b="IFFVSli/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7540606A321;
	Mon,  9 Nov 2026 20:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7540606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=IFFVSli/
ARC-Seal: i=1; a=rsa-sha256; t=1794257262; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=E98HJo4M9xbxdr894U55ndlMxcGrMXf4IZiUI2186xilrWWrK+VG5p6micoS1kwGVPTtS1zJ9bY8NWcxbw3wI2SNFk4sc55tc07qaWYSLlrW+hKrtLnW3dNtBxR7zfyEKqJDFRYw/Oar7zOV6kut8Zb1sp8rAhaSV7vkK3LIXNc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794257262; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hAko9zGkmi9niJtZOL71kVVVwwbmLc2t5MHh5r5eE0o=; 
	b=LyaXY6Obyfmz9ip0+Slx4XjSlVg8teruIXtc4tnbM9WBqTXeFsQoIolV7T85UOvBFFBIzSldbXnO1ia1qbFxL7mwI2RGQAtFsvLKuuUaDncb/cgsWOXPmjoBuejRtnUgMzj4FYVO2ArARKNqpCBPIOrfXaCqF7vmjfmFF3TTlVI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=IFFVSli/fpGgICQj52Xp3TckmHGAzWCHrwGBi2PqqOm2PEHLoPZqCOCANftleC+kptSgcc0ElcHEuqoJIhlT5DN4piVmO0yIxB7SYiLNjUkn9LegPLlZu3GLs7sjAwhO39SYvwRc3IfyGYAbvT0fwrev/fZ+l4+aqp3IOrnCF7U=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=hAko9zGkmi9niJtZOL71kVVVwwbmLc2t5MHh5r5eE0o=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794257260723543.4215096609604;
	Mon, 9 Nov 2026 21:47:40 +0100 (CET)
Date: Mon, 09 Nov 2026 22:47:39 +0200
From: Igor Velkov <iav@iav.lv>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] PCI: rockchip-host: Enable async probe by default
Message-ID: <20261109204122.async-probe-reply@iav.lv>
In-Reply-To: <20261109202202.GA265423@bhelgaas>
References: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>
 <20261109202202.GA265423@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 09, 2026 at 02:22:02PM -0600, Bjorn Helgaas wrote:
> I don't know what the SD card has to do with PCIe.  Seems like there's
> some SD issue, and making PCIe async happens to avoid it?  Sounds
> fragile to me.
>
> Other changes like c0e1eb441b1d justify it by allowing other drivers
> to load in parallel to reduce boot time, which is a good reason.  But
> apparently here it makes a functional difference as well, which feels
> sketchy.  E.g., what other drivers need to use async probe to avoid
> similar issues?

You're right that the real problem is ordering: nothing makes dw_mmc wait
for the RK3399 io-domain driver, which sets the 1.8 V level of the SD
pins. [1] tried to add that dependency and was not merged. Async probe
only stops this driver from holding the deferred-probe worker for ~0.7 s;
any other slow probe in that window breaks UHS the same way.

Is there a way to express this dependency that you would accept?

[1] https://lore.kernel.org/all/20230904115816.1237684-1-s.hauer@pengutronix.de/

--
Igor Velkov
