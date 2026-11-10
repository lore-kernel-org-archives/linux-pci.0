Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.149.154.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315031;
	b=0nqAranutpY51dpXb01iUQTAzi1MNjVKaD+rPEnuty98pdTn8q9nrAZ75/4My6UsA6pU
	 m4H+ylOIBi73I4AC+7x/+7csUYZRtc7WowbLeT+gQb2vHw1S/Do/0wo4JGCVuSlKghnHE
	 5xGZUEQo+AqMJJnczAxZHVk0tUNF9yeBK523L01QWjn6+fJaX/LKuESCDgSK1SCkleOfV
	 zpur3YH5B9PJ5/7ljixNECuMpIiEQEfXk0I6ZYgRF4uLGskFN+7ln/hdQZeKrF4JpQqqp
	 SyHIpj2MTKYaNie6fT7xQqWQNg65B6aQ4aufbDOmCoTFiIq4dxH1PqtZq6yhCrOT30g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315031;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ke8k9Pom61RVocDNSNi53TyKiWzenyLEQQdp9t8ox30=;
	b=M81yonpbMZPkhFnt2qBLIhJwDxRUCvvT9JU6VVnALdZs+SCIqQx/nqQZNseDtWRITDs3
	 EmPo5qaDWYx8TlPCJyzsPgFgshX8+GwCy+7UVEAMztiuJ+qRVw2s2f+QXr+f/kUK6ewZk
	 Dmhcfss32WncC7ZHFG8/HXyzYEFplORI1EnjtoMtAAlFMp8mEoD1fbo81nLR4rZMmhCCM
	 lkop0lxJ7AKo8+93dZd+bjFFvzxUZNP4abGlmLT4yq8ycqLYcac8v8PRARaXMYZLzJTUR
	 F4CvqQym0zoar0xH+UiwWQ0bpxu5/0U6oQH6anVNEYyMFhW/EtvQ0GbGNNlYD3BvUjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntiq.com;
	spf=pass smtp.mailfrom=sntiq.com;
	dkim=pass header.d=sntiq.com header.i=@sntiq.com header.a=rsa-sha256 header.s=dkim header.b="JfqZ/YIU";
	arc=none smtp.remote-ip=45.149.154.214
Received: from mail.sntiq.com (mail.sntiq.com [45.149.154.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEED606A325;
	Tue, 10 Nov 2026 12:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEED606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntiq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntiq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntiq.com header.i=@sntiq.com header.a=rsa-sha256 header.s=dkim header.b=JfqZ/YIU
Received: from node (unknown [9.246.125.159])
	by mail.sntiq.com (Postfix) with ESMTPSA id 2C99420388;
	Tue, 10 Nov 2026 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sntiq.com; s=dkim;
	t=1794315023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ke8k9Pom61RVocDNSNi53TyKiWzenyLEQQdp9t8ox30=;
	b=JfqZ/YIUuz4GxqIqD4Jjz41VKX3cxuq7ciZ9Tv+AeGzYDUxrsS5Kwqf6mbSDDjTTNX/Ug+
	dBz4B6ZzGaowXcsKdUHfGfLS+CkIUljW4nowiAnEkr9qIK4HkamKldTr+20nVo0tLlm2ZC
	NPyZIS2+c5u7E9ISye1DRQoon0El60RiNxsq6r+Slv6nzk7JckffwG6QRg6o7RbepnhDtJ
	Mvw5NqsTPBUytpgrxLwtDGbpVog/kKNykA0ZlW23suHYXWgMu6X2xQCkTuU9npe9DJE2jf
	PcbaL4FGMEwY+Dz9hKVEvDgfEctmMUZOgDknN8ridjiezU8jvzsu33l6t6XXDQ==
From: David Glushkov <david.glushkov@sntiq.com>
To: Diogo Sousa <diogogsousa@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable async suspend for AMD rev 0x62 ACP and HD Audio
Date: Tue, 10 Nov 2026 13:50:24 +0100
Message-ID: <20261110125025.2753861-1-david.glushkov@sntiq.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <5cdc7ef0-e18f-4afc-96b2-ee4e92bc29ee@gmail.com>
References: <5cdc7ef0-e18f-4afc-96b2-ee4e92bc29ee@gmail.com>
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

(Resending in plain text, my previous mail was rejected by the lists
because of an HTML part.)

Hi Mario, Bjorn,

I'm the author of the A9WJG subsystem-ID quirk that Diogo mentioned in his
commit message, so a data point from the MSI side.

I hit the same problem on an MSI Raider A18 HX A9WJG (MS-182L): the ACP is
rev 0x62 (1022:15e2 at 6a:00.5) with the Ryzen HD Audio controller
(1022:15e3) at 6a:00.6, and HD Audio stops working after resume, same as
Diogo describes. This is on the CachyOS 7.3 kernel.

Regarding the BIOS question: I'm on the latest BIOS for this model,
E182LAMS.31B (dated 05/26/2026), so a BIOS update isn't available as a
workaround here either. That makes at least two different vendors (ASUS
and MSI) with the latest firmware still affected.

Given that, a generic fix keyed on the ACP revision, as in Diogo's patch,
looks preferable to per-board subsystem-ID quirks. I'm happy to test any
follow-up version on this machine.

Thanks,
David
