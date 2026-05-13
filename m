Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9D3822A2;
	Wed, 13 May 2026 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676859; cv=none; b=AwMxg/I84PUB1UTw9GQVwnsY5Omkg47C7AXXhb2VaM6EV5ruvq8yggecyAj7bMUDHL7ttgvBeIjgblejyljuzccv9a0ZcaBwgYbONoOzx1JLkLuaCgr9RhtVpJ3ysYnKa47cKVyQopRhVslPXRlfiyMIx5/yjWLs4Hw6djoP7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676859; c=relaxed/simple;
	bh=OJsyPInWocERSlgb3lGrySA04TNXJ5H6Jbb87o9N/Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNe6RmhoYFiDISr+yXKHvwXQKFbdPoD7/kYD/6g1ddDOqiUdoPakOovMV1xR+WTbIGjeEu1rPBN9c0Vy6lJhikKHFNd50HdpZkdZhtzMQCt9q5KKo77qrhPhD8faCU/x73bySicqjHfJaowqTVcICjQk6GNNBI+LJl2/c0RhtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ5I5+Yk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ5I5+Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29595C2BCB7;
	Wed, 13 May 2026 12:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778676859;
	bh=OJsyPInWocERSlgb3lGrySA04TNXJ5H6Jbb87o9N/Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ5I5+YkGU5icYwDDOor0lyCEDnpEp9LhRrSFFDCoFEPgE7JNApXC/WnfYN9qDUFp
	 UyQfvZN2TMo8HJFly1mwz4+SgD3uL9ZZvXx1pwHH+5h1QHMh2NxS6bNMkF+OmKeP8I
	 rlL0+1JqNzY8+zCXpVRxwrUO2GqQUOswEIfv9huNf+vAky0KtTcv5FS81DzG9g663z
	 BWwLdOH2h0RotH8thYCc+ge9nUuRA2iBL6IUOaDglUKYHS9cBILFMKo9A770dw7gFt
	 Kk0GpPngRw677wuxR0CwEZbZPLdxWXf65LpifrmDUendiZRMq44u/DsIMXs4mGdZ/c
	 Q6IAwNDfQ4JjA==
Date: Wed, 13 May 2026 18:24:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON
 fields
Message-ID: <krw54q4tkodjfoatbqtccxj6q3v5dg62uv2ipybnp3vjshqkus@kernwmwlqepy>
References: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
 <20260428-t_power_on_fux-v5-1-f1ef926a91ff@oss.qualcomm.com>
 <bc3a5f58-676a-3634-6b8f-bffc91d25265@linux.intel.com>
 <28c30ddb-f46a-458d-9680-eac1ce8c5b68@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28c30ddb-f46a-458d-9680-eac1ce8c5b68@oss.qualcomm.com>

On Wed, Apr 29, 2026 at 08:34:58AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/28/2026 2:57 PM, Ilpo Järvinen wrote:
> > On Tue, 28 Apr 2026, Krishna Chaitanya Chundru wrote:
> >
> >> Add a shared helper to encode the PCIe L1 PM Substates T_POWER_ON
> >> parameter into the T_POWER_ON Scale and T_POWER_ON Value fields.
> >>
> >> This helper can be used by the controller drivers to change the
> >> default/wrong value of T_POWER_ON in L1ss capability register to
> >> avoid incorrect calculation of LTR_L1.2_THRESHOLD value.
> >>
> >> The helper converts a T_POWER_ON time specified in microseconds into
> >> the appropriate scale/value encoding defined by the PCIe spec r7.0,
> >> sec 7.8.3.2. Values that exceed the maximum encodable range are clamped
> >> to the largest representable encoding.
> >>
> >> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >> ---
> >>  drivers/pci/pci.h       |  6 ++++++
> >>  drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 46 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >> index 4a14f88e543a..c379befe1ebe 100644
> >> --- a/drivers/pci/pci.h
> >> +++ b/drivers/pci/pci.h
> >> @@ -1110,6 +1110,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
> >>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> >>  void pci_configure_ltr(struct pci_dev *pdev);
> >>  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
> >> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value);
> >>  #else
> >>  static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
> >>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> >> @@ -1118,6 +1119,11 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
> >>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> >>  static inline void pci_configure_ltr(struct pci_dev *pdev) { }
> >>  static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
> >> +static inline void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
> >> +{
> >> +	*scale = 0;
> >> +	*value = 0;
> >> +}
> >>  #endif
> >>  
> >>  #ifdef CONFIG_PCIE_ECRC
> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >> index 925373b98dff..457d469b8d49 100644
> >> --- a/drivers/pci/pcie/aspm.c
> >> +++ b/drivers/pci/pcie/aspm.c
> >> @@ -525,6 +525,46 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
> >>  	return 0;
> >>  }
> >>  
> >> +/**
> >> + * pcie_encode_t_power_on - Encode T_POWER_ON into scale and value fields
> >> + * @t_power_on_us: T_POWER_ON time in microseconds
> >> + * @scale: Encoded T_POWER_ON Scale (0..2)
> >> + * @value: Encoded T_POWER_ON Value
> >> + *
> >> + * T_POWER_ON is encoded as:
> >> + *   T_POWER_ON(us) = scale_unit(us) * value
> >> + *
> >> + * where scale_unit is selected by @scale:
> >> + *   0: 2us
> >> + *   1: 10us
> >> + *   2: 100us
> >> + *
> >> + * If @t_power_on_us exceeds the maximum representable value, the result
> >> + * is clamped to the largest encodable T_POWER_ON.
> >> + *
> >> + * See PCIe r7.0, sec 7.8.3.2.
> >> + */
> >> +void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
> > Hi,
> >
> > I don't know how the type for t_power_on_us was picked but if it was 
> > arbitrary decision, I suggest you just go with 32-bit input.
> The maximum value of the T power ON is 3100us, so we are using u16 here.
> 

FWIW, I made sure dt-binding restricts the max value to 3100us:
https://github.com/devicetree-org/dt-schema/commit/3579443c5d2f5a8bbedd1ad8e6cc634ce0aa02e3

- Mani

-- 
மணிவண்ணன் சதாசிவம்
