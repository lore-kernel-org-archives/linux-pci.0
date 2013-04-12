Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Stephen Warren' <swarren@wwwdotorg.org>
CC: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"olof@lixom.net" <olof@lixom.net>, Hiroshi Doyu <hdoyu@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	"mturquette@linaro.org" <mturquette@linaro.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Fri, 12 Apr 2013 22:13:35 +0530
Subject: RE: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B36FB300@BGMAIL01.nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
 <51630ABB.1020200@wwwdotorg.org>
In-Reply-To: <51630ABB.1020200@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> > Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> >
> > - Enable pcie root port 2 for cardhu
> > - Make private data structure for each SOC
> > - Add required tegra3 clocks and regulators
> > - Add tegra3 specific code in enable controller
> > - Modify clock tree to get clocks based on device
> > - Based on git://gitorious.org/thierryreding/linux.git
> 	
> A couple more points on this patch:
> 
> * You didn't mention that this series is based on Thierry's work-in-progress
> tree, and not something immediately destined for upstream. As such, only
> Thierry is expected to actually apply any of these patches.
> 
[>] Stephen, I have mentioned it in comment description as Based on git://gitorious.org/thierryreding/linux.git, is this not enough?

> * Your changes to the Tegra PCIe driver require that device tree include
> extra clocks and regulators. You need to update
> Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt to describe
> these new requirements.
[>] Should I create tegra30-pcie.txt? or made changes in tegra20-pcie.txt itself?
