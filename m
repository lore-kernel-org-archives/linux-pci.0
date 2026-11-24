Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511075;
	b=AqhLDtgJ1njZr6ykDivzaGvOm+vtImfbgPgwvXAlSZP74Iy23hlnqsikxO6A+7NXcOjt
	 yvZDRw3dDVtxBLmOUn/757ecNGYHoiF+Utg7K+DBsFdmfASCVfHzDyysTGuXxOSXFVQcg
	 8Ct8/JzDAFhjWzrlIUfdMMe1J3+acmM3pFAbrKaiYk2fx71Bhz7c4zqBRUfsxkSKrQJQW
	 k7sdjpw/mt9Z0UwHL6qflgqJTNeQWf+eLbufOHRAYLyOz0dQ+4IKB0O66JMqS1hddKcq5
	 6Um+WDft/+Rf6GI2HUhgUUwkoVtSxSyJf/UF5Sz3PcmFxH1ARImpp/o+wIIKQddqLqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511075;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5DT6oaaA7LWmL2YLzzcHrexo0FY3ouJ9ZlAjAiTLqIk=;
	b=IDm3+JZNY6nPvgwlnRW0005xwzL17g3tKLHPumzX2Cs3KVo5kghFJe+xjVQjsRHkp+51
	 PdRtlKoVNOZj9wCMbkODq2RIlhU/aFrw6wu+mIcQfnGtEMrseyJz4IcWaazw7Ggbq7dj1
	 VeYIMe6KrzQxvFX0BZGxELAYWC+3wPyosGdyOxf5YuGYNZ5UmQvFpQUCoqIv9ehG9W1s8
	 Ap6cFL5uMkXd0mS/V8DxZ4xp8dSBbS04j8jgSMZPAaTa0lpIqyJZ1+wyT2oVm/NiasHdx
	 rxIwfDTyL1jZVyOYkk9/mTv6QmEGi38WPX1stF8UZlZmHfdYNQ/R7F9SDEueGyAi0Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B1606A31E;
	Tue, 24 Nov 2026 09:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 521B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 97342374;
	Tue, 24 Nov 2026 10:04:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 81FF0606F538; Tue, 24 Nov 2026 10:04:31 +0100 (CET)
Date: Tue, 24 Nov 2026 10:04:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <awVTHwYMP753-iSu@wunner.de>
References: <av7BRHcVkXOGT6yp@wunner.de>
 <20261120181841.GA893187@bhelgaas>
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
In-Reply-To: <20261120181841.GA893187@bhelgaas>

On Fri, Nov 20, 2026 at 12:18:41PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 19, 2026 at 10:28:36AM +0100, Lukas Wunner wrote:
> > https://lore.kernel.org/r/cover.1794997749.git.lukas@wunner.de
> 
> There were minor conflicts with Yazen's patches in
> sysfs-bus-pci-devices-aer but nothing serious, and if we rework the
> negative value handling in the ratelimiting parameters they would
> mostly disappear.

I've reviewed the changes to sysfs-bus-pci-devices-aer on pci/aer
and they LGTM.  I will review again if/when updates of Yazen's
patches happen.

One more thing:  sashiko flagged two valid issues in patch [7/7] of my
above-linked-series (which is now the top-most commit on pci/aer).
I've provided a fixup patch for both findings at the bottom of my reply
to sashiko:

https://lore.kernel.org/r/av4j5j9-In1uWC8T@wunner.de/

Could you fold this into the commit?  Alternatively, I'd be happy to
submit these as two separate patches if that is preferred, with a
proper commit message to explain each change.

Thanks,

Lukas
