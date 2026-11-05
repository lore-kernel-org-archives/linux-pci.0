Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793843122;
	b=tqQZOYE66b9ORffW6qKiqY+iheX0939LVk5VA2g7G+tPFrVC6MeLUPqXgJzad4hdZbK1
	 DYoKTRhJooXIN+1v/tWo3JWXDYIqYqyrOW3iK49Vmo5TvfXswb1L5XdDwIfEx10tJktvL
	 ab7gcHm8VYGaq1WO8yz7fItffAzYuf+WvZPkDrN/W7Pu6JDDbtduB/cLbhK4rNZzipFaD
	 Y5nbHo7sn3ZoQ0W0WpPRtd2WmUz/rel7MW7jtKZNvtWbG0VkiayabRVoPUNXAjDLbaD+A
	 BFuO+PAeyhXtw4XBjmDNYw5zQb76HDidtEDcnuu4j7hK/s0KlSKGjmcEmmg+e6SxL2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843122;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qz2KgSvxs/QubGSn6ctkR3NuYfESAeObXcUr3tbspdM=;
	b=QVCp7ncA13V4N7Rc73BINaXg8GbDpY48GNd1w/4/ehOJyTz1E7dmAU2z0/PV+cK+5gyK
	 TNTKtCdxS/cg+tZXouyc4JveyApXgwdmNrnCdXQIKnyAm7BgfQlXOXrOMF+AWCFoBZBpG
	 Ap/Djgt6P++xeqXoItY6UEf2S1+yw6DU2FV6ZaGjXD3fxdYff0e9MijVmPX9/o3KdDNN8
	 lfRnsSAjlXttI0Oks0a6i5NoIfDSRQpQeWz5rpEd7uBwDuF2YqE4ZJcaViWx9hl0fqfVk
	 tg/Jpja1YIGe8oahiambdUp7NAU0IBsOKYRL9aNFz3B0YUzCMllQ25BGUprOydh6RUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=by21JAX5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD4606A32D;
	Thu,  5 Nov 2026 01:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AD4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=by21JAX5
ARC-Seal: i=1; a=rsa-sha256; t=1793843096; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Yuofk1O36nbwUk0teyUxBHcwFtB6oYbW8laHO1bPwqKjuaUVxh2pNk2cVRd6reWo2zokw7ekbkYk7qPOcBooOIq8RGAFinerkkj/EfmgsW9z70wMYNWznUIrZuY2OBIfiQfzpfEJQdmRU0X0e/4zPaI92fEqGq/CAfZmw8zBBNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793843096; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qz2KgSvxs/QubGSn6ctkR3NuYfESAeObXcUr3tbspdM=; 
	b=cAqXRxjmIvDH9BHAkZOnilJaKMfbXcp+dX49vSKTW+vO6w8mErwWQseqw9YeV33p1StRXSVYMbce7q2+rRuGn2FYJpL68+OTG51tzfrP/L68GQBNbPf8MYSf+Q8nXLEIt7Dc73N94S+GCQzTgba/iHXgqY+oP4YFhfCRgW3h8dk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=by21JAX5eS17IyPINnm3VUQLZdKacWLqLKfQqeNoPP+8mDh++WkkOA5DPxoDEywi2BQ1NgJXLJHkXLgv4NVRPbZ8hI1cJLWEgQcOBhn2J/qblujzvpAjDH/ehWy//ktm9ZEMGuuaI9akOSWIgfgOpygsDkfjvpuyuuqyXN7dKR8=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=Qz2KgSvxs/QubGSn6ctkR3NuYfESAeObXcUr3tbspdM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793843093919792.6849770156605;
	Thu, 5 Nov 2026 02:44:53 +0100 (CET)
Date: Thu, 05 Nov 2026 03:44:52 +0200
From: Igor Velkov <iav@iav.lv>
To: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Cc: iav@iav.lv, shawn.lin@rock-chips.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, dlemoal@kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] PCI: rockchip-host: Make the PERST# inactive delay configurable
Message-ID: <20261105-ehbello-perst-v5-tested-by-1@iav.lv>
In-Reply-To: <20261104215848.2087944-1-ehbello@gmail.com>
References: <20261104215848.2087944-1-ehbello@gmail.com>
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
Content-Transfer-Encoding: 8bit

Tested on Helios64 (JMB585 behind a GPIO-switched slot supply) and
ROCK Pi 4A (empty slot and a WD SN770 NVMe), 7.3.1 with the series
backported, one s2idle cycle per boot:

  Helios64, no property:          resume 20/20, abort in rockchip_pcie_rd_conf() at probe on 1 of 21 boots
  Helios64, <10> probe and s2r:   resume 20/20, the same abort on 1 of 21 boots
  ROCK Pi 4A, empty slot, none/<10>:  10/10, 10/10
  ROCK Pi 4A, SN770, none/<10>:       10/10, 10/10, NVMe readable after each resume

The default behaves as before, and 10 ms changes nothing here; the
slow JMB585 link on Helios64 shows up at the same rate with either
pulse width.

Tested-by: Igor Velkov <iav@iav.lv>
