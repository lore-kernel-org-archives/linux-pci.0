Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142F30C605;
	Wed, 18 Feb 2026 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415705; cv=none; b=ZdfoWRjJgFnlaCzecRb8UXMAIs6tiJFXejGuUfiT8zJRuI1zGhA83tsi0BRt6GxmWAPYiq14PXLLO7/9a4iOdNiP1MQ1qeWQpyWtJzOvqbnImXgU3tEXuYkGMpnqtbLdJnuMYtaU23kxPDshwbZ1I8DFBb7szXBDVimlKUEib88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415705; c=relaxed/simple;
	bh=p7tzHZzQXsc9rW01uIXe3faKSoecW8rk/n5ZV0TmxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOCDUd/G8tnNtNAJydJaRSRN1ys9N7z+Lgv8pm6EpxIFLS/pmfhEg2DlOFObQE/PTIWsFNLhU1rk9MUNG10hFjT9A9ujuQ0zSCTF+oHY12g8JNI4xpkNCvFQTbTo3DHMwi6swyeeh63w93QyrYaK1+C6eZWZcZzmnUg0B8EtQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQsjwg2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQsjwg2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F38DC19421;
	Wed, 18 Feb 2026 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771415704;
	bh=p7tzHZzQXsc9rW01uIXe3faKSoecW8rk/n5ZV0TmxrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQsjwg2dGgmG5xyyHwXLW0xYPfSgdVG7P5xKJ0wDIPrwhTdPxIWY2WHcnMfmSJyLe
	 EKGiqqxP0D1NAxc8CBlHTBRTvAFQ/dLf/Qqoz3lOvFpx6ZllRqxw9gw1aCAilSeNOY
	 q5t5B+7v2Je2jWBjEnhS55b25we3XUGVX5c4MdwnujCP0BVUPd/ESj54TgNcOEKgMj
	 GMYdeAoI6y0cTr4SVdb5ddfdbk1nl4RAUaCei3pIpgf+hoN7KLfiGuaSoOR82nNHPL
	 N3RVvOQb4Hp5A8G+aA4bv6HY8c8z05QcQYlR3GKSZ2eLdEGNQaZ+h0Qhg+JGVdkbjS
	 E7E/HYsZShJFA==
Date: Wed, 18 Feb 2026 17:24:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI/pwrctrl: A couple of fixes
Message-ID: <bdto5xxlqnzm56dekbg6bk3vhhvo4ijigcakulrw5ouui22yjb@perf22wxnzxb>
References: <sq6wub733a7lwmwpjsxp6cxnl3zchzn632b6ni342f4g63rlz3@poxbx7d5vc4y>
 <20260217170329.GA3381022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217170329.GA3381022@bhelgaas>

On Tue, Feb 17, 2026 at 11:03:29AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 17, 2026 at 09:54:43PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 17, 2026 at 10:06:08AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 17, 2026 at 03:48:45PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > Hi,
> > > > 
> > > > This series fixes a couple of issues introduced in the recent pwrctrl rework
> > > > for v7.0. Both issues are due to some incorrect assumptions on deciding when to
> > > > create pwrctrl devices. First issue is due to assuming that all OF graph nodes
> > > > require pwrctrl and another one is due to assuming that all PCI child nodes are
> > > > PCI devices.
> > > > 
> > > > Both issues are fixed by changing the pwrctrl device creation logic in
> > > > pwrctrl/core.
> > > > 
> > > > Testing
> > > > =======
> > > > 
> > > > This series is tested on Lenovo Thinkpad T14s.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > > Manivannan Sadhasivam (2):
> > > >       PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
> > > >       PCI/pwrctrl: Only create pwrctrl device if the device node is of type "pci"
> > > > 
> > > >  drivers/pci/pwrctrl/core.c | 51 ++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 38 insertions(+), 13 deletions(-)
> > > > ---
> > > > base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> > > > change-id: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7
> > > 
> > > Are these v7.0 material?  I assume the pwrctrl changes merged for v7.0
> > > were tested but maybe not on this platform or this DT structure?
> > > 
> > 
> > Yes!
> > 
> > > Is there a functional regression from v6.19 to v7.0 that would justify
> > > including these in v7.0?
> > 
> > Atleast patch 1 is a fix for the regression on IPQ platform, but patch 2 is
> > required for an upcoming support.
> 
> Upcoming support sounds like v7.1 material.
> 

Actually, issue fixed by patch 2 is discovered by an upcoming support, but the
issue is there already in theory. That's why I wanted to merge it for 7.0.

> Re patch 1, I'm not really up on the OF graph situation (git grep "OF
> graph" in the kernel tree finds several mentions but no pointers,
> other than "bindings/graph.txt", which doesn't exist), so I don't know
> how to recognize the DT that leads to the problem.  I guess we must
> need a PCI endpoint node that contains an OF graph element but no
> power supply property?  Maybe an example would help?
> 

'OF graph' is the terminology that is used to refer devicetree graph properties:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml

For modeling the M.2 connectors, we used OF graph. The connector node is linked
to the PCI RP node with the help of 'remote-endpoint' graph property as below:

&pcie6_port0 {
	reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;

	port {
		pcie6a_port0_ep: endpoint {
			remote-endpoint = <&m2_pcie_ep>;
		};
	};
};

And in the pwrctrl core driver, we assumed that the existence of the 'port' and
'remote-endpoint' properties mean we have a link to the M.2 connector. But
apparently, there are a few platforms like IPQ9574 which has ath12k devices with
WSI interface which also use graph properties:

            wifi@0 {
                compatible = "pci17cb,1109";
                reg = <0x0 0x0 0x0 0x0 0x0>;

                qcom,calibration-variant = "RDP433_1";

                ports {
                    #address-cells = <1>;
                    #size-cells = <0>;

                    port@0 {
                        reg = <0>;

                        wifi1_wsi_tx: endpoint {
                            remote-endpoint = <&wifi2_wsi_rx>;
                        };
                    };

                    port@1 {
                        reg = <1>;

                        wifi1_wsi_rx: endpoint {
                            remote-endpoint = <&wifi3_wsi_tx>;
                        };
                    };
                };


And here, the graph properties are used to link WSI interfaces of one or more
ath12k endpoints together. But they don't need pwrctrl here. So our existing
assumption was wrong and that's what being fixed in patch 1.

> And I guess the problem is that the PCI controller driver probe is
> deferred indefinitely, waiting for a pwrctrl driver that doesn't
> exist, so no PCI devices are ever found?

Exactly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
