Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620043;
	b=3RvpHHVjt+HZhJ6i+9vzHz8Jta6/Rlz3zYxN4yP2k0/T0pCEuZ+WOozxN+B8fPwHBsYL
	 Oby3+n3aQ4e6ECKg4fkCa0zAouiVWzrtSyx86Q1AOgEigrSApaKfOUjr69iLByx5UkVFo
	 +vMzMuhB4ge49imEruQ6jpATEG/sk7dy00DU25SpqGXdBSGpYFic3tNSVZA46kslX5iih
	 kofoYqxztI+rEI7NDXbw8DSG83DP2NB2+20HE3+v+d3CFUDg0NoP1WWPEBb7bo+T2wXqu
	 EY3wH3VWlKgEHv/9sIfn9oTNIGF1qKI1Zf1ii0UVyZYvht1bnQTnhC7tMkihdm4Y0vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U7BBvICMuzzfnr5B7tFxaU0ZRbyofyJaoqar4LTl4jM=;
	b=ZLyopJwp41kwiQ2S4LDGA04O/VY2/nrXq/sX1eh/HYbE7f1CiCIY0cuoNCg4cTG2qfTX
	 ful6zuQMNuh4UEA1I04exyKZw93/RIJdxWKM5qygAMqQ8srNjjaGsgaRvJyJYfzbpG+cz
	 KDYCTjETUN9YKq24lKjsIoHjZavqvXOH69d4y0BXVPheLTNPlO1JtCZMvZlLMZqv+jNP4
	 kNldWB1bqu/XE9b9pkrk5WFUtjNlPKiKv0KjVsQUOAmgzn2o73i6cZT12oToS3SBZJrZT
	 jdjNQIfXd8cTJ28l/CTERbvPVOiNXrvq5YR/56tOnvztqMiWncBkVkgktzZdKcXouIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPs7IeC2;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB7606A32A
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 15:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7AB7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPs7IeC2
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b896db8f9bso572587a12.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 07:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620041; x=1796224841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U7BBvICMuzzfnr5B7tFxaU0ZRbyofyJaoqar4LTl4jM=;
        b=jPs7IeC2SRkubIeMfVnhV/BhR49WqE7eahuEzR6lok9Tb6/91SnF6JgW3QvDRw9VIh
         I8NXvAazDYFAWvjL2/R5Brx3YKskZH5+t8TClG/n/H7N+mfcNGnDHTDUYE1iF4lz2sEr
         8MYzT/BBWPa8yU7bqPNSmvXOtyWTyA1wfph9fhRL7dRFWXFf+9LEenZH6NXyAJikaLMU
         w8Hx8OOb/rRljzVrIGU1RJDznnDds1VoXnAS5QjAQd45pF9bXy8nA/pg/XPK4KzKRJ4H
         uSKUl3EeuMxVaUeOXhKmwnIIrFIln8gdmrREcmWQiKyU3yrUkBvxnZ90UvLKy+OBlrFi
         +yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620041; x=1796224841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7BBvICMuzzfnr5B7tFxaU0ZRbyofyJaoqar4LTl4jM=;
        b=WfABudH9ZK8Nlh40iDShC2FmXxdIYJIyAjKpo9AMWU3d2g190TeyDjSmim3YJ6oDvQ
         S9b5ZaZJ4YlfzKTr+egsMAcJiuDjHtnBKBc9qbF1ZLDbmMlOr6OSOvVxr3ww94rVZgWz
         PjS72J51X3Kaoh1puR4sFN2+RE+HAOiL4uJdMSGUqkAcMcloGS7J3FfkjGtxHfC5VoCP
         4wArP7Tsc2dV3STI9F7+UIhyZpi4Deu3KfjUqMkDNpklkUvNsU8z61Dhuy5YROXdPmrT
         XDVWp8SsISHVaP5fcXNaOFiY+Qb85bnYyMLJfIRIExddFMqYgoyG4jCoKbLNiIPoShfM
         3HZA==
X-Forwarded-Encrypted: i=1; AL+hErHFEhU6Y6uDNGKF8KPEFxN6irUZUQJWMojHi1QqidvCaz3Sc7EtTEq8DP+d8mLgthNxTRFsqQuNxKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zsQgTecfIYTblZWk/fBNA9aPmBK8hWYJJr9SF5m10PQfq8CRB
	AfsR9RMkibYsYrZZQ0hYUnykuZh+Bc7W24hw8spQwKnrzJX6zn3h+M3e
X-Gm-Gg: AZFdTZfWESTbDPMgkhJPKtre4nXUsyEpLDRe/vAVyHT8SvA0RqmVayxqZrqiDnn3d5G
	R5M6GXg1zY6O+rKico/L+6Glf3t6CQONc6+/Gqvjm1jLFNILsge1Hj7kBEbMhDSte7s2T+A3Mjj
	tjhGQNMkvgui6SSVTOSmY6v1m0oAFC8Pc04vB8Jlrz7vtV4Tg7de2Dm4rtXHLgj1Ce5Wh1A7HOy
	7ukBf1NbDxDowPk/tUlncy7zFHo9uOeRovK1sc424vSvHM2shIuPmz0TiSk4KEdfeDAXo7hsYSe
	ulsdYlIgfs9OZJoyGO4HKQkeGQzFIo8BxfuRBdSDRSYPOJWmmHZtenq8FhSjaiC4u8/8j8s56ee
	LbDUukFmzOiCEdBbnIVKNWSlc5sjOvkKsoKGCttQMqvJGe98UGWtiD+9s/DVQir35dRD9vlHP2J
	pzNwdS+7cd6m5m9P4pwOqmKB7eQ+eVxFYqVg/doSVoxbGf5esd7dNFrqaKpVowckbBlgNiBOYvf
	65MeU/hwD+du4u2GVGPxzsQ040W5rIcJCVnpRAhbxPIc82z6HhJKoaEnL6j+at8cx2x0TFf0eD3
	nempybXAU87iVl7hsBuj
X-Received: by 2002:a05:6402:90d:b0:6b7:dace:635d with SMTP id 4fb4d7f45d1cf-6ba37ac9214mr15694051a12.0.1795620041130;
        Wed, 25 Nov 2026 07:20:41 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e78a7sm8131962a12.16.2026.11.25.07.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:20:39 -0800 (PST)
Date: Wed, 25 Nov 2026 17:20:36 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aksh Garg <a-garg7@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rhys Tumelty <rhys@tumelty.co.uk>, 
	Manikandan K Pillai <mpillai@cadence.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Hans Zhang <18255117159@163.com>, Yao Zi <me@ziyao.cc>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 4/8] phy: core: Add phy bulk data helper functions
Message-ID: <awb8ZycWk2PJzTUD@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-5-inochiama@gmail.com>
 <20261125043639.249525-5-inochiama@gmail.com>
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
In-Reply-To: <20261125043639.249525-5-inochiama@gmail.com>
 <20261125043639.249525-5-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:35PM +0800, Inochi Amaoto wrote:
> Add several helper functions that allow drivers to get several phy
> consumers in one operation. If any of the phy cannot be acquired then
> any phys that were got will be put before returning to the caller.
> 
> This can relieve the driver owners' life who needs to handle many phys,
> as well as each phy error reporting.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Transient build warning due to improper patch splitting, please fix.

Documentation/.renames.txt: warning: ignored by one of the .gitignore files
../drivers/phy/phy-core.c:1202:12: warning: unused function 'phy_bulk_get' [-Wunused-function]
 1202 | static int phy_bulk_get(struct device *dev, int num_phys,
      |            ^~~~~~~~~~~~
../drivers/phy/phy-core.c:1242:12: warning: unused function 'of_phy_bulk_get_all' [-Wunused-function]
 1242 | static int of_phy_bulk_get_all(struct device_node *np,
      |            ^~~~~~~~~~~~~~~~~~~
../drivers/phy/phy-core.c:1274:13: warning: unused function 'phy_bulk_put_all' [-Wunused-function]
 1274 | static void phy_bulk_put_all(struct device *dev, int num_phys,
      |             ^~~~~~~~~~~~~~~~
3 warnings generated.
