Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF1432E89;
	Thu, 16 Jul 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212334; cv=none; b=QCxHWVY+6B/FIqlA8kOzfUbRSLa21Tf1Gvck5eOL3KUd0tzwN+zOZFIOxXzD2j5blf0heQS4bFAiOrR8oaU/nxaHQNAPJtfWdK6Dj/FSuXlxwLduW3t1Yy3KhUXKMy6cBKmCBVD/bnnD2b0CEbr/aoIXJlOrpKK0vtB/1P7i9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212334; c=relaxed/simple;
	bh=uw6Hpxud7kiwPehwNcjmOYzHTJdRf1MA93+xe7zg0L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbsli6rucITGWCdI7SXrAAZ32KbNoPcl3tNz436kauKKjaG/db9SHGFFASw+mI3Xh7pq8KDD8UmIEAO8XBW6JYwCa/ll3l5HQE45cQTVKy8AnlYpV2o86BpfnqlKy6tNWjCiEpcQRuTvACbdpKsJvNIMBdQLSdR6mPDeRPeC4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPEg4a5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPEg4a5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F751F00A3A;
	Thu, 16 Jul 2026 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212331;
	bh=m9ZGMnmPrwOTbiG0Qage08QMuLa/iq9hFmvvE1rVLUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UPEg4a5LYB05d5wJfgXnOLCZ+sEDMox3rskxFnpH/7j3NdsTvGeOkYm8qF/od+cjI
	 GsKsZmQmjBNpgbKadgs2KY0o2EfrViVuxWAC+6IlJWTVjwRc3Axg1E7jZw47CF/5gY
	 9R81aQ3fP1GfS2urqb8V2O29hflP7irLGgkR7Umx5sUrHRN3x97NoQ1aVpr20LkKWM
	 udSVMZqN8Tp0EQU1O/PJqYSvTjInW5U0FMmBMF6QLVEJBZeMGBApEu0XrrKTN1NlJo
	 7LGhBr9wqjklMIFxNaFNxWXimJQ/hlJlsl6jprOcNX2iTL5gwmGBtq7oOyifH+dVLh
	 VmJ8iLegRaSkw==
Date: Thu, 16 Jul 2026 16:31:57 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Message-ID: <44rsqo4pggrvqqx476fd2kmhebct7jul7ttbrwaafsymhsw46y@37d5t6lkcncq>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-11-46253587af64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710-monza-wireless-v3-11-46253587af64@oss.qualcomm.com>

On Fri, Jul 10, 2026 at 11:57:37AM +0200, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

One comment below. With that fixed,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index f67a554adf956696aeac2348e478dbd0b74f0e62..e3d3d68932efff494f3c7ab96d75869be24c4a94 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -155,6 +155,40 @@ vreg_nvme: regulator-3p3-m2 {
>  		enable-active-high;
>  		startup-delay-us = <20000>;
>  	};
> +
> +	wireless-lga-connector {
> +		compatible = "qcom,pcie-m2-1418-lga-connector",
> +			     "pcie-m2-e-connector";
> +		vpcie3v3-supply = <&vdc_3v3>;
> +		vpcie1v8-supply = <&vdc_1v8>;
> +		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&nfa725b_default_state>;
> +		pinctrl-names = "default";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* WiFi/PCIe */
> +			port@0 {
> +				reg = <0>;
> +
> +				lga_pcie_ep: endpoint {
> +					remote-endpoint = <&pcie_bridge_ep>;
> +				};
> +			};
> +
> +			/* Bluetooth/UART */
> +			port@3 {
> +				reg = <3>;
> +
> +				lga_uart_ep: endpoint {
> +					remote-endpoint = <&uart10_ep>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &cci1 {
> @@ -409,6 +443,22 @@ pci@0,0 {
>  		ranges;
>  		reg = <0x010000 0x00 0x00 0x00 0x00>;
>  
> +		pcie@1,0 {
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			compatible = "pciclass,0604";
> +			bus-range = <0x00 0xff>;
> +			ranges;
> +			reg = <0x020800 0x00 0x00 0x00 0x00>;
> +
> +			port {
> +				pcie_bridge_ep: endpoint {

Can you change 'pcie_bridge_ep' to 'pcie_ep'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
