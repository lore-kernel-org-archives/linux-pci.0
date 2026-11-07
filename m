Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071172;
	b=l7JuvmB88fi0Z21oxyovSyYww7M8r8Yhhl8SFVnm7iqniDV2B8e9KwTWW81s+T9VmHMK
	 Nb/gVysBpQnUewZifpD0UjSuTBbO5szJrwda1PUpkUFXFtBIY4g0SL0JKTOVd+eRXHKyi
	 xv2V4c4diVAhNJcoRzfS8GSOlvsTtS9dquMWm7N75uLjKQFrwsVb0oy5R/xbGlhJSX976
	 eqv8ptj7ZjHTG82yTEvmzKpixaAA/p/JkGPIaLrNA4wcA4PdpNETfNDS4Nyao5ew8A1Wj
	 tIrgICFHMJDvUsive2al7Io5hqjlNnE6UghBrZEYmLVtYymSV2mJCzF2IkvKgUah1mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071172;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=1orH5xtF0huo2qGzhqaqtOYDknfk3GU5H09iF9woKaE=;
	b=Z1r+CGcV8EyBp8r93uITqZF6dgQoWspMf3oXgHVvK48FeyuqspbJQ6igkbO2U+WxGVLA
	 eHHri6mSNvvJAgYv+X3CkG+eEV3BB3IHX1lIdPtlm0IwOfZQfbv6tGTmp9PDx7Py1f33L
	 BHiyTqRgIMsp0wq0FoKpXl6DE+A+AO91SjlWQ5EUMYaqrQKj3IxJlXfQHgJi9UY5K+wg5
	 0P1pbtJm8bRpCY2ypF1b1uSiGazN6A5fezrz2sPigwNXb9qvbYDBQIfRS7mhiEzq2Fxw9
	 wXK/03LxVeeZ/JUDqGenn+MhoaS/yMy4b3ag2UwlBc1ssNQ/7WH4aiH67yYB/eM6mFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz6AX5n7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B3606D830;
	Sat,  7 Nov 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz6AX5n7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B2C1F008A1;
	Sat,  7 Nov 2026 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071171;
	bh=1orH5xtF0huo2qGzhqaqtOYDknfk3GU5H09iF9woKaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rz6AX5n7ZPDXU+vNW2Ek3TD9vV0joqowoS+4dzeEFwLyZmLK4DOGVNNJYQyBMLDyK
	 u6K6tCik+3LDaqjnsqxJUGl0ROS/mG/McMoaN4ykogQNG1V2gQf20/XKKXF+jKKzLW
	 fJQfdrTiW+wn0ODEsh+Xny3m43DdUGe/qYcxbfb3BI3GvLTnYNVvMO1e7sBx/VaxPs
	 s3FMOkEGtEuoeUR5dMMNXqrYlUXAANaTUJzO2ao/wnvzfnJe2++NapnKuF+A4BGRo5
	 AGPlFYACiXh5odWDo+JVi6Ig7+b23dDevQd8wnbsrczx15FOaO5bpYGCfKaV/GJU0o
	 pU+5g2Li1W4yg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: nirmal.patel@linux.intel.com, bhelgaas@google.com, robh@kernel.org, 
 kwilczynski@kernel.org, lpieralisi@kernel.org, 
 asutosh.pathak@linux.intel.com, 
 Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
Subject: Re: [PATCH v10 0/7] VMD add second root bus support
Message-Id: <179407117125.87472.9079167905703065780.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:36:11 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Fri, 06 Nov 2026 18:42:48 +0000, Szymon Durawa wrote:
> This series adds support for a second VMD root bus.
> 
> Today the VMD driver can enumerate and manage devices only behind the
> first VMD root bus. Starting with Intel Arrow Lake, VMD may expose a
> second root bus (BUS1), and devices behind that bus are not discovered
> by the current driver.
> 
> [...]

Applied, thanks!

[1/7] PCI: vmd: Add vmd_bus_enumeration() helper function
      commit: 9ec146e311d1bb69e1e76e523d5a2631838e9f2d
[2/7] PCI: vmd: Add vmd_configure_cfgbar() helper function
      commit: 2f3f85305a90be0b1f71636a55c286db49a49cb8
[3/7] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
      commit: ed34664daffa63d455fc3a614d0722e57183a9ce
[4/7] PCI: vmd: Add vmd_create_bus()
      commit: b294e381f1de731dfbf8f7b150818fbb73120622
[5/7] PCI: vmd: Replace hardcoded values with enum and defines
      commit: 7aa850769255689870bd19080da2a398ac583d93
[6/7] PCI: vmd: Convert bus, busn_start and sysdata to an array
      commit: 99b617df5c36773206c492790863985137fb189a
[7/7] PCI: vmd: Add support for second rootbus under VMD
      commit: 4d790512e44ae235166faddf7cf10ade0c86c4a8

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


