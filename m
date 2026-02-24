Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DB2989B0;
	Tue, 24 Feb 2026 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916960; cv=none; b=A4ELuX1GkUfFvcpvnCghCxRfoN73u98sLKsWNxtt/SqCj6cEWJZ2rvZ1B1voYT7tzWLvi3rIwDnfdYxEcKjjiGHEB2PWVKd69t0r8ARyQCQPyuRws07XPsbDaBkldviMrr1MzHnEmZfTOSDAquRE4j28fNvEEo6zcWCQAaOrVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916960; c=relaxed/simple;
	bh=1qlmj3BqzE+0ZGQDuqGDZoZh4B0NZy3eXBhDSGRTahs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcubD8KW4ZfQsNhMc5/a0cOCAJruUF1CMSsTVXFYYna+9e1P8NThbUr8DAl4ir397p4fc+++biv6qAR52jpa+5gOxBIMtggeiX7RYMNcvCsNorxWBhef/lYE1aDwqcD2H6pTog5zl17KpbR9qjVpV2UF9aCKr2PiQsRRFJKE3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0a0tK4x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0a0tK4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D508C116D0;
	Tue, 24 Feb 2026 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771916960;
	bh=1qlmj3BqzE+0ZGQDuqGDZoZh4B0NZy3eXBhDSGRTahs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0a0tK4xNgGMM/MtPHj6zYx8R2qTm7i4dUfHbC7a2t9mhOOjdqIMR7UT8pb6vS00e
	 gZKX6hCLCOshLQY3SUnxxX1FHQajonXyyrlOjr0K3tdn7X0fuADixaYyCBB7Pr/gEW
	 JbgqhWmaoXAGUvGGXlrw6rIHM2LQC7WbYFWGMU6A7jUoWee/yTyZ8ONUmjdMUXBka4
	 n+/6gkY2kcbLtMWP9uk8dUS7uzGDBPbAUD16l8Hn5eKjLIsiKu6uz6nvpd11jHYOg7
	 0fn9sAEli3iGzVPZ8BeKmEWeH3E06VZ5KWaqENdHi+ayih36ZKKZF0SZ/hdGd8oy1H
	 SRzqxprq1X9iw==
Date: Tue, 24 Feb 2026 08:09:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/9] dt-bindings: serial: Document the graph port
Message-ID: <20260224-peacock-of-improbable-poetry-b4cfdc@quoll>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-4-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224-pci-m2-e-v5-4-dd9b9501d33c@oss.qualcomm.com>

On Tue, Feb 24, 2026 at 11:00:50AM +0530, Manivannan Sadhasivam wrote:
> A serial controller could be connected to an external connector like PCIe
> M.2 for controlling the serial interface of the card. Hence, document the
> OF graph port.
> 
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)

Please drop. The binding is not being sent to the device during testing,
thus it is impossible to test it.

Best regards,
Krzysztof

