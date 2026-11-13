Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530288;
	b=A9gCcZhPQbdYSUWfW0sD2TjtGLh+bm11KsiKpnaYqCXOPDY+UD+lo7scP6pgUU3mNLDg
	 9YjUKcAJbXdXMlVgm2BOp1fi2VP/ReytOcvJotIGTViWh5uSfNxRtjYi+h3JSYZPf27X8
	 RpREotYUKtG6FLTbn+ch/V6ltt8o1ScFh3cIn7Ndmo/H5+gb8NmlmzUcFj0cJePuRrFzL
	 SmLWKwR2Q8ChUX4wcdkMZJjQfjLSX19fTKa63sYW16+QQ5hOT7CMpgJBQFLJjvvxKQPx2
	 myp2XJSq9i8IW08mPlahQ5VkW3NoqCoB862UcdxrR/DMHrX3B3D8q9tL3Nl/IlTPVeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JrLg/6b9RqsXrMXKx+iE2vsv7SoB1VWe2RrESbsV7DU=;
	b=CczlaamNch9DrpbXp1EYI+aLFv7lnRZyAPsYEACWZ+Ld1dEE1YO74JjhkN3pwh/TFATn
	 tG5d4kI2RFz+7i71VKPRf7oepinJC4NqWoqTGidtz0kBbZmNRlpAww5FwpkUXiUOHxK2y
	 pR7G0bH65JuYBtq4/8X07r42SLrRMuxlfYemETmwAI6lSQyYLzLT2jSNVajreCpFxYwVX
	 hltfzHG5WuOS2SYU7imuyChofR29Tl1J36O3KeDbwkWdFSSGtY5LSQQ3Dk2JhcghIIhC/
	 MvunsEiI2hxjntjoyX981ClPutyipDPpPtaN0VJq4u0uTxH6nUiPVoMr3IZF4cTFFfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqaEO2p4;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65273606A8A8
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 00:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65273606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqaEO2p4
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so253517f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 16:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530287; x=1795135087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JrLg/6b9RqsXrMXKx+iE2vsv7SoB1VWe2RrESbsV7DU=;
        b=jqaEO2p4KozWg3cT0zJJyyU2ju2gxQwzUpzu/yvEpYiKjul+s5I5Eja2hKy1ZNdrF6
         IzK0faJLnWokqfoPXOybeTmYYscgl27T97r2C2TqaAeln3nT0yDS2TBfrgaE6iZSqYBd
         P9l+Z3e0obV5O/nAIhal2/s/UvQuwKUn4auZlloLAYJOsLoEfHSjWBmoB3cKnDbZ+OYS
         r5YWrp3O7wQ1iDrb9dYa3zultLU0KMRwOSZi48xIYOlwM4toJBPjaou+Qz+oyDNGHW7L
         Z/s2AI0yFlLJDdIK97iF5lZ64dtvK4H+H7eiO7/twhkt98ULk94K0L9yZC3DiYVg3Ato
         KZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530287; x=1795135087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JrLg/6b9RqsXrMXKx+iE2vsv7SoB1VWe2RrESbsV7DU=;
        b=YckFtK+W6xdoniRNwMazvRcrVErFFEgbDdXcNtqQJsRggzE+94bnEpnxaA9zOpWnxm
         NkGCk/n+bddbEl3K87jHXmWs4iQ5BtDOHAuIp3i863Qqb4GlgnqjQVfc6XWVAiE2tcW7
         F7iW4tjUoK0OV2yVEInkPThUMD4zfhaltljIRN8QL+LDob3FRRD4/d0LfYeFBiAEeir/
         QGDFUyfW+4l0Z0HCaVLRJsGYDp6v6r/AU8a/F5Ig9BO1F/PMHYCabGLpdPMQiFheBBBg
         RxrIdcqjYXc1KdJcqp8R4hbAesrEQn9dGSB6sevU9liVzuvSRnCIf0vIuXMHOrG09gc4
         XbAg==
X-Forwarded-Encrypted: i=1; AL+hErF+1OzfDZSaeIdHR+syNd31GZXvU3nt6vXf3TBWlOePCkTFdV8y73n0s9/u7CWEKxLFB4dsDFDSzi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rxyJRjr1EtD2kOnd5kHed9GGNHg9fFH8Oh9kjmiRt8vCdV+yw
	MIZPxQoW5AXv9Nbsna1kK+dm4Do+/i+JNef5qY0ZphghBn8+OlGa6UzM
X-Gm-Gg: AYBFou3wQEAQasj+r4tbsGSJj5S6sxy1AaTElxLMredvAdZ/YQHhQ1A10ce5KM0Rzfg
	G9hTBYNYOHwPg8X3QKo35JcmGsqYLAZBPiAjQv9L876Z65p0SkWp3MS7mzLMQFM5GucsYbsPTzI
	vqwrnNcRfiQ/l2qZaQfVmxWjTAP8QS5MCREx4ICY6xtz0G2fo3TCPxgdJ8wHk6XdvygYzHb/nUO
	F7VJPb3lm7DT9+b77LHJLLVcxJVJRMpws3tHmSQEk/MhXo1d7AptDHkUukhpBU9zCB/b7C9WNJm
	/QjVhe3uO2ZpqmheXNJZDT2CZ6nDkpl9t6vHmQvQ5RfCymQgu7+EK+CDhSeawyF40YLVIEnDJb3
	nS8vkYYgRhrNTG2MO4JbfxCnuj8+zUZgjFYL6Aw8SVCdJPgahd2+c2M8FkOFPpxDTMOO2qxV6Lg
	9zSmAjYN5lepOwAJFEZILjYj4sWSpzxr2SIri6YexMXlNcdyayDqTnGY8BHaPDS6Cdjrep4xqVi
	NWOt43uWAZZFkYuBLmwwHScvb+BaDJv2sH66xoBg3GOWkreU1LybaPnbRfaRdZWNtMeNYfw1qz3
	N5Tn1JmA6hhc6xXENBQjwBJmrsVNT9e7gZoGnQ9Nqu6lyYmri2uNuSZTKSnTavmwrybeFEcRT0w
	tuDFxI0JrgboAGdS80+7IyHaURIN4GKdkz4T17+lSzTCRycSc9Trwtp5BS3zzvHssbe2Ysxhe6/
	tkZZooZkGv5beQsY3A
X-Received: by 2002:a05:6000:4718:b0:48e:d7c:4bc3 with SMTP id ffacd0b85a97d-49b0287cd7dmr8979495f8f.21.1794530286812;
        Thu, 12 Nov 2026 16:38:06 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223b21sm2410376f8f.2.2026.11.12.16.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:38:06 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 13/24] PCI: dwc: Add ZTE ZX279128S host controller driver
Date: Fri, 13 Nov 2026 00:38:05 +0000
Message-ID: <20261113003805.3669702-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014131954.GA1623979@bhelgaas>
References: <20261014072109.1759502-14-ghahramani.navid@gmail.com> <20261014131954.GA1623979@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Bjorn Helgaas wrote:
> Suggest making the subject line:
>
>   PCI: zx: Add ...
>
> or whatever tag you plan to use for the family of hardware this driver
> will support over time.  Future changes to a driver typically don't
> include "dwc" because the name of the driver itself is more useful.
>
> I see "zx" used in the spi patch and "zte" used in the clk patch.
> "zte" might be too generic; there may be future hardware that requires
> a different driver.  "zx279128s" might be too specific; there will
> likely be more SoCs that share this driver.  Same consideration
> applies to filename, config symbol, struct and function names, etc.

Thanks. I will use zx for all of them in the PCIe series, so the
subject PCI: zx:, pcie-zx.c, CONFIG_PCIE_ZX, struct zx_pcie and the
zx_pcie_* functions.

> Capitalization of "zx279128s" here (menu item, help text, comment
> below) should probably match the commit log and marketing materials
> for this SoC.

Stefan suggested lower case for these SoC names in a reply, so I will
write zx279128s in the commit log as well and the two will match.

Best regards,
Navid
