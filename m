Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF830EF7F
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741779; cv=none; b=a/3wSM7wQ90pX/B5kOYXtgbHoVfV29Igy8wAgFe/vN3H3ivZBTrHNr6RpsV3S9QfwAEoKH2pkA6EIDikIP1mTIM8ZTSK8/MyDK5t4C9w5CoSZTZQEN5HaqY17O1NHfU97USxLIT8FIEcdg0aSy1U/J9mMJdDe8GWrafjYBAVGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741779; c=relaxed/simple;
	bh=x0osV0/LlVn5jAug/OgRRywJb516W6Ny6v5CNH7QrVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plqd9z0hfQ8qVXlC94B4J0022qrSAlOiu1y3PhQmiZ5GGF0kFC0r95w/Es3OSz5gQyjL5QALsh3Xf49sWD9Y48U+Vm8Fo/6C1lYejJAB5bCV1dzexi/wYKg0WXPBFIH5ec2uF7l/NyAZYTayuLuolsd/UbE+2yD/xVpP5zV6v08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qfxqr4ow; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qfxqr4ow"
Message-ID: <5262c5b1-84cc-4abe-9d8a-a8fd48b6c79f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770741774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqNtSPfXtXfusc1DAQX8JYXdbD+b429MioZG5bRqt3Y=;
	b=Qfxqr4ow/3kY9MqO/6sXjJUSJbobDYRIEAnhj5QIwAV6uyun425IHX9smykzza55LWjBpK
	mO7KforSp0k4INbVMEgOl9TD7vA0nWrvvKCg2W4hoUkkkDRVupt6ymC1JoaoRppFsvmJNb
	MF1cJcbySy7uIntWYmarUADkWBzwLJ8=
Date: Tue, 10 Feb 2026 11:42:50 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/8] phy: zynqmp: Calibrate ILL if necessary
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vinod Koul <vkoul@kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-5-sean.anderson@linux.dev>
 <CY1PR12MB9697F67210064132883611A8B762A@CY1PR12MB9697.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CY1PR12MB9697F67210064132883611A8B762A@CY1PR12MB9697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/10/26 11:04, Pandey, Radhey Shyam wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Tuesday, February 3, 2026 5:51 AM
>> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; Vinod Koul
>> <vkoul@kernel.org>; linux-phy@lists.infradead.org
>> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>; Lorenzo Pieralisi
>> <lpieralisi@kernel.org>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; linux-kernel@vger.kernel.org; Simek, Michal
>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; linux-
>> pci@vger.kernel.org; Neil Armstrong <neil.armstrong@linaro.org>; Rob Herring
>> <robh@kernel.org>; Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
>> Manivannan Sadhasivam <mani@kernel.org>; Bjorn Helgaas
>> <bhelgaas@google.com>; Sean Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH 4/8] phy: zynqmp: Calibrate ILL if necessary
>>
>> init_serdes in psu_init_gpl is supposed to calibrate the ILL. However, this
>> may fail if the reference clock is not running, such as if the clock needs
>> to be configured on boot. To work around this, add support for ILL
>> calibration in U-Boot. If the ILL is already calibrated (any non-zero
>> value) we skip calibration.
>>
>> The algorithm is substantially the same as serdes_illcalib [1], but it has
>> been updated for readability (and to remove all the "if (lane0_active)"
>> conditions). Due to the amount of register fields, many of which are
>> undocumented (especially the chicken bits), I have mostly used defines only
>> for the register names. There are certainly areas where register writes are
>> superfluous, but I have left these in order to minimize deviation from the
>> procedure in serdes_illcalib.
> 
> Please consider splitting the patch in introducing calibrate ILL functions
> and then subsequently using them.

OK

> How did you validate the changes? functional testing is one part
> but I think better to match register configuration done in psu_init vs
> this series?

I've done this in the past, but I didn't do so with this version of the
driver. I'll make sure to do this comparison for v2. FWIW the ILL
values achieved through this procedure are fairly close to the values I
got from the firmware.

> Have we tried running on multiple designs having
> different GT lane and protocol combinations .

Currently tested with SATA on GTR2 (on [1]) and PCIe on GTR0/1 (custom
design). I've also tested SGMII and DP on the other lanes (although not
USB as mentioned in the cover letter). I'd definitely appreciate if you
(or anyone else) could test on some other boards.

[1] https://developer.seco.com/hardware/product/computer-on-modules/smarc-modules/som-smarc-zu-b71/

> There are multiple magic numbers. Consider renaming it to
> meaningful defines.

Some of the fields have very long names. E.g. L0_TX_ANA_TM_3 has two
fields that we set: TX_serializer_enable and
force_TX_serializer_enabled. Setting it would look like

			xpsgtr_write_lanes(gtr_dev, lanes, L0_TX_ANA_TM_3,
					   L0_TX_ANA_TM_3_TX_SERIALIZER_ENABLE |
					   L0_TX_ANA_TM_3_FORCE_TX_SERIALIZER_ENABLE);

and there's really no way to get that under 80 characters. This is
probably the area where I could most improve things. But I'm not a fan
of tripling the line count since I think it makes it harder to follow
the flow of the initialization.

Other fields have poor documentation. E.g. L0_TM_IQ_ILL8 has a single
field ill_bypass_iq_polytrim_val documented as "IQ ILL polytrim bypass
value." I have no idea what this field does or why it needs to be set to
0xf3 so I can't really define a meaningful constant for it.

Lastly, some fields are not documented at all, notably UPHY_SPARE0.

In these latter two cases, I have not guessed at the semantics, but I'd
more than welcome any additional info.

>>
>> [1] Example implementation; xpsgtr_phy_illcalib coresponds to
>>     serdes_illcalib_pcie_gen1:
>> https://source.denx.de/u-boot/u-boot/-/blob/v2026.01/board/xilinx/zynqmp/zynqmp-
>> zcu208-revA/psu_init_gpl.c?ref_type=tags#L710
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>  drivers/phy/xilinx/phy-zynqmp.c | 421 +++++++++++++++++++++++++++++++-
>>  1 file changed, 420 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
>> index 152af1702bbd..854b0ea04648 100644
>> --- a/drivers/phy/xilinx/phy-zynqmp.c
>> +++ b/drivers/phy/xilinx/phy-zynqmp.c
>> @@ -12,6 +12,7 @@
>>   * PCIe should also work but that is experimental as of now.
>>   */
>>
>> +#include <linux/bitfield.h>
>>  #include <linux/clk.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/delay.h>
>> @@ -31,6 +32,7 @@
>>   */
>>
>>  /* TX De-emphasis parameters */
>> +#define L0_TX_ANA_TM_3                       0x000c
>>  #define L0_TX_ANA_TM_18                      0x0048
>>  #define L0_TX_ANA_TM_118             0x01d8
>>  #define L0_TX_ANA_TM_118_FORCE_17_0  BIT(0)
>> @@ -50,16 +52,49 @@
>>  #define L0_TXPMD_TM_45_ENABLE_DP_POST2       BIT(5)
>>
>>  /* PCS control parameters */
>> +#define L0_TM_ANA_BYP_4                      0x1010
>> +#define L0_TM_ANA_BYP_7                      0x1018
>>  #define L0_TM_DIG_6                  0x106c
>> +#define L0_TM_DIG_22                 0x10ac
>>  #define L0_TM_DIS_DESCRAMBLE_DECODER 0x0f
>>  #define L0_TX_DIG_61                 0x00f4
>>  #define L0_TM_DISABLE_SCRAMBLE_ENCODER       0x0f
>> +#define L0_TM_AUX_0                  0x10cc
>> +#define L0_TM_MISC2                  0x189c
>> +#define L0_TM_MISC2_ILL_CAL_BYPASS   BIT(7)
>> +#define L0_TM_IQ_ILL1                        0x18f8
>> +#define L0_TM_IQ_ILL2                        0x18fc
> 
> #define L0_TM_IQ_ILL3                   0x1900
> 
> IQ_ILL(n) = 0x18f8 + (n - 1) * 4 ?
> 
> Similarly for others  (when applicable)?

OK

>> +#define L0_TM_ILL11                  0x198c
>> +#define L0_TM_ILL12                  0x1990
>> +#define L0_TM_E_ILL1                 0x1924
>> +#define L0_TM_E_ILL2                 0x1928
>> +#define L0_TM_IQ_ILL3                        0x1900
>> +#define L0_TM_E_ILL3                 0x192c
>> +#define L0_TM_IQ_ILL7                        0x1910
>> +#define L0_TM_E_ILL7                 0x193c
>> +#define L0_TM_ILL8                   0x1980
>> +#define L0_TM_IQ_ILL8                        0x1914
>> +#define L0_TM_IQ_ILL9                        0x1918
>> +#define L0_TM_EQ0                    0x194c
>> +#define L0_TM_EQ0_EQ_STG2_CTRL_BYP   BIT(5)
>> +#define L0_TM_EQ1                    0x1950
>> +#define L0_TM_EQ1_EQ_STG2_RL_PROG    GENMASK(1, 0)
>> +#define L0_TM_EQ1_EQ_STG2_PREAMP_MODE_VAL    BIT(2)
>> +#define L0_TM_E_ILL8                 0x1940
>> +#define L0_TM_E_ILL9                 0x1944
>> +#define L0_TM_ILL13                  0x1994
>> +#define L0_TM_CDR5                   0x1c14
>> +#define L0_TM_CDR5_FPHL_FSM_ACC_CYCLES       GENMASK(7, 5)
>> +#define L0_TM_CDR5_FFL_PH0_INT_GAIN  GENMASK(4, 0)
>> +#define L0_TM_CDR16                  0x1c40
>>
>>  /* PLL Test Mode register parameters */
>> +#define L0_TM_PLL_DIG_33             0x2084
>>  #define L0_TM_PLL_DIG_37             0x2094
>>  #define L0_TM_COARSE_CODE_LIMIT              0x10
>>
>>  /* PLL SSC step size offsets */
>> +#define L0_PLL_FBDIV_FRAC_3_MSB              0x2360
>>  #define L0_PLL_SS_STEPS_0_LSB                0x2368
>>  #define L0_PLL_SS_STEPS_1_MSB                0x236c
>>  #define L0_PLL_SS_STEP_SIZE_0_LSB    0x2370
>> @@ -69,6 +104,7 @@
>>  #define L0_PLL_STATUS_READ_1         0x23e4
>>
>>  /* SSC step size parameters */
>> +#define TM_FORCE_EN_FRAC             BIT(6)
>>  #define STEP_SIZE_0_MASK             0xff
>>  #define STEP_SIZE_1_MASK             0xff
>>  #define STEP_SIZE_2_MASK             0xff
>> @@ -76,6 +112,7 @@
>>  #define STEP_SIZE_SHIFT                      8
>>  #define FORCE_STEP_SIZE                      0x10
>>  #define FORCE_STEPS                  0x20
>> +#define TM_FORCE_EN                  BIT(7)
>>  #define STEPS_0_MASK                 0xff
>>  #define STEPS_1_MASK                 0x07
>>
>> @@ -84,6 +121,32 @@
>>  #define L0_REF_CLK_LCL_SEL           BIT(7)
>>  #define L0_REF_CLK_SEL_MASK          0x9f
>>
>> +/* Built-in self-test parameters */
>> +#define L0_BIST_CTRL_1                       0x3004
>> +#define L0_BIST_CTRL_2                       0x3008
>> +#define L0_BIST_RUN_LEN_L            0x300c
>> +#define L0_BIST_ERR_INJ_POINT_L              0x3010
>> +#define L0_BIST_RUNLEN_ERR_INJ_H     0x3014
>> +#define L0_BIST_IDLE_TIME            0x3018
>> +#define L0_BIST_MARKER_L             0x301c
>> +#define L0_BIST_IDLE_CHAR_L          0x3020
>> +#define L0_BIST_MARKER_IDLE_H                0x3024
>> +#define L0_BIST_LOW_PULSE_TIME               0x3028
>> +#define L0_BIST_TOTAL_PULSE_TIME     0x302c
>> +#define L0_BIST_TEST_PAT_1           0x3030
>> +#define L0_BIST_TEST_PAT_2           0x3034
>> +#define L0_BIST_TEST_PAT_3           0x3038
>> +#define L0_BIST_TEST_PAT_4           0x303c
>> +#define L0_BIST_TEST_PAT_MSBS                0x3040
>> +#define L0_BIST_PKT_NUM                      0x3044
>> +#define L0_BIST_FRM_IDLE_TIME                0x3048
>> +#define L0_BIST_PKT_CTR_L            0x304c
>> +#define L0_BIST_PKT_CTR_H            0x3050
>> +#define L0_BIST_ERR_CTR_L            0x3054
>> +#define L0_BIST_ERR_CTR_H            0x3058
>> +#define L0_BIST_FILLER_OUT           0x3068
>> +#define L0_BIST_FORCE_MK_RST         0x306c
>> +
>>  /* Calibration digital logic parameters */
>>  #define L3_TM_CALIB_DIG19            0xec4c
>>  #define L3_CALIB_DONE_STATUS         0xef14
>> @@ -139,6 +202,9 @@ static const char *const xpsgtr_icm_str[] = {
>>  #define TM_CMN_RST_SET                       0x2
>>  #define TM_CMN_RST_MASK                      0x3
>>
>> +#define LPBK_CTRL0                   0x10038
>> +#define LPBK_CTRL1                   0x1003c
>> +
>>  /* Bus width parameters */
>>  #define TX_PROT_BUS_WIDTH            0x10040
>>  #define RX_PROT_BUS_WIDTH            0x10044
>> @@ -148,9 +214,13 @@ static const char *const xpsgtr_icm_str[] = {
>>  #define PROT_BUS_WIDTH_SHIFT(n)              ((n) * 2)
>>  #define PROT_BUS_WIDTH_MASK(n)               GENMASK((n) * 2 + 1, (n) * 2)
>>
>> +#define UPHY_SPARE0                  0X10098
>> +
>>  /* Number of GT lanes */
>>  #define NUM_LANES                    4
>>
>> +#define SIOU_ECO_0                   0x1c
>> +
>>  /* SIOU SATA control register */
>>  #define SATA_CONTROL_OFFSET          0x0100
>>
>> @@ -338,6 +408,33 @@ static void xpsgtr_restore_lane_regs(struct xpsgtr_dev
>> *gtr_dev)
>>                            gtr_dev->saved_regs[i]);
>>  }
>>
>> +static inline void xpsgtr_write_lanes(struct xpsgtr_dev *gtr_dev,
>> +                                  unsigned long *lanes, u32 reg, u32 value)
>> +{
>> +     unsigned long lane;
>> +
>> +     for_each_set_bit(lane, lanes, NUM_LANES) {
>> +             void __iomem *addr = gtr_dev->serdes + lane * PHY_REG_OFFSET
>> +                                  + reg;
>> +
>> +             writel(value, addr);
>> +     }
>> +}
>> +
>> +static inline void xpsgtr_clr_set_lanes(struct xpsgtr_dev *gtr_dev,
>> +                                    unsigned long *lanes, u32 reg, u32 clr,
>> +                                    u32 set)
>> +{
>> +     unsigned long lane;
>> +
>> +     for_each_set_bit(lane, lanes, NUM_LANES) {
>> +             void __iomem *addr = gtr_dev->serdes + lane * PHY_REG_OFFSET
>> +                                  + reg;
>> +
>> +             writel((readl(addr) & ~clr) | set, addr);
>> +     }
>> +}
>> +
>>  /*
>>   * Hardware Configuration
>>   */
>> @@ -351,7 +448,7 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>>       u8 protocol = gtr_phy->protocol;
>>       int ret;
>>
>> -     dev_dbg(gtr_dev->dev, "Waiting for PLL lock\n");
>> +     dev_vdbg(gtr_dev->dev, "Waiting for PLL lock\n");
> 
> Unrelated change.

We reconfigure the PLL many times during ILL training, and this debug
output makes it difficult to read the ILL calibration debug.

>>
>>       /*
>>        * For DP and PCIe, only the instance 0 PLL is used. Switch to that phy
>> @@ -520,6 +617,231 @@ static void xpsgtr_bypass_scrambler_8b10b(struct
>> xpsgtr_phy *gtr_phy)
>>       xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61,
>> L0_TM_DISABLE_SCRAMBLE_ENCODER);
>>  }
>>
>> +/* Enable or disable loopback */
>> +static void xpsgtr_phy_set_loopback(struct xpsgtr_phy *gtr_phy, bool enabled)
>> +{
>> +     struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>> +     u32 reg = gtr_phy->lane >= 2 ? LPBK_CTRL1 : LPBK_CTRL0;
>> +     u32 shift = gtr_phy->lane & 1 ? 4 : 0;
>> +
>> +     xpsgtr_clr_set(gtr_dev, reg, 7 << shift, (u32)enabled << shift);
>> +}
>> +
>> +static void xpsgtr_phy_set_ill(struct xpsgtr_phy *gtr_phy, u32 ill, bool gen2)
>> +{
>> +     u32 val = 4 + ill * 8;
>> +
>> +     if (gen2) {
>> +             xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL2, val & 0xff);
>> +             xpsgtr_clr_set_phy(gtr_phy, L0_TM_ILL12, 0x0f,
>> +                                1 << (val >> 8));
>> +     } else {
>> +             xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL1, val & 0xff);
>> +             xpsgtr_clr_set_phy(gtr_phy, L0_TM_ILL12, 0xf0,
>> +                                (val >> 4) & 0x10);
>> +     }
>> +}
>> +
>> +static bool xpsgtr_ill_calibrated(struct xpsgtr_phy *gtr_phy)
>> +{
>> +     u32 ill1 = xpsgtr_read_phy(gtr_phy, L0_TM_E_ILL1);
>> +     u32 ill2 = xpsgtr_read_phy(gtr_phy, L0_TM_E_ILL2);
>> +     u32 ill12 = xpsgtr_read_phy(gtr_phy, L0_TM_ILL12);
>> +
>> +     dev_dbg(gtr_phy->dev->dev, "lane %u gen1 ILL was %u gen2 ILL was
>> %u\n",
>> +             gtr_phy->lane, ill1 / 8 + (ill12 & 0x10 ? 32 : 0),
>> +             ill2 / 8 + (ill12 & 0x02 ? 32 : 0));
>> +     return ill1 || ill2 || ill12;
>> +}
>> +
>> +static void xpsgtr_init_ill(struct xpsgtr_phy *gtr_phy)
>> +{
>> +     struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>> +     struct clk *clk = gtr_dev->clk[gtr_phy->refclk];
>> +     u32 ill123 = DIV_ROUND_CLOSEST(clk_get_rate(clk), 1000000);
>> +
>> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_MISC2, 0,
>> L0_TM_MISC2_ILL_CAL_BYPASS);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL1, ill123);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL2, ill123);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL3, ill123);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL7, 0xf3);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL7, 0xf3);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_ILL8, 0xff);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL8, 0xf3);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL8, 0xf3);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL9, 1);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL9, 1);
>> +     xpsgtr_clr_set(gtr_dev, UPHY_SPARE0, BIT(5), 0);
>> +}
>> +
>> +static void xpsgtr_phy_illcalib(struct xpsgtr_dev *gtr_dev,
>> +                                  unsigned long *lanes, bool gen2)
>> +{
>> +     bool last_ok[NUM_LANES] = { 0 };
>> +     int pass[NUM_LANES] = { 0 }, altpass[NUM_LANES] = { 0 };
>> +     int best[NUM_LANES] = { 0 }, altbest[NUM_LANES] = { 0 };
>> +     unsigned long lane;
>> +     int i;
>> +
>> +     /* Initialize the BIST */
>> +     xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0xe0, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FILLER_OUT, 1);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FORCE_MK_RST, 1);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_DIG_22, 0x20);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_2, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUN_LEN_L, 0xf4);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_INJ_POINT_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUNLEN_ERR_INJ_H, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_L, 0xfb);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_CHAR_L, 0xff);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_IDLE_H, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_LOW_PULSE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TOTAL_PULSE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_1, 0x4a);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_2, 0x4a);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_3, 0x4a);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_4, 0x4a);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_MSBS, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_NUM, 0x14);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FRM_IDLE_TIME, 2);
>> +     xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0xe0, 0);
>> +
>> +     for (i = 0; i < 64; i++) {
>> +             bool ok[NUM_LANES];
>> +
>> +             for_each_set_bit(lane, lanes, NUM_LANES)
>> +                     xpsgtr_phy_set_ill(&gtr_dev->phys[lane], i, gen2);
>> +
>> +             /* Reset lanes */
>> +             xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_7, 0x20,
>> +                                  0x10);
>> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x00);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0x40);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0x80);
>> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x04);
>> +             udelay(50);
>> +             if (gen2)
>> +                     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x0e);
>> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x06);
>> +             if (gen2) {
>> +                     xpsgtr_write_lanes(gtr_dev, lanes, L0_TX_ANA_TM_3, 0x04);
>> +                     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x07);
>> +                     udelay(400);
>> +                     xpsgtr_write_lanes(gtr_dev, lanes, L0_TX_ANA_TM_3, 0x0c);
>> +                     udelay(15);
>> +                     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x0f);
>> +                     udelay(100);
>> +             }
>> +
>> +             if (xpsgtr_wait_pll_lock(gtr_dev->phys[0].phy)) {
>> +                     memset(last_ok, 0, sizeof(last_ok));
>> +                     continue;
>> +             }
>> +
>> +             udelay(50);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0xc0);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0x80);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0xc0);
>> +             udelay(50);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0x80);
>> +             udelay(50);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0);
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0);
>> +             udelay(500);
>> +
>> +             /* Do the BIST */
>> +             for_each_set_bit(lane, lanes, NUM_LANES) {
>> +                     struct xpsgtr_phy *gtr_phy = &gtr_dev->phys[lane];
>> +                     u32 packets, errors;
>> +
>> +                     xpsgtr_phy_init_bus_width(gtr_phy, PROT_BUS_WIDTH_10);
>> +                     xpsgtr_phy_set_loopback(gtr_phy, true);
>> +                     xpsgtr_write_phy(gtr_phy, L0_TM_DIG_22, 0x20);
>> +                     xpsgtr_clr_set_phy(gtr_phy, L0_BIST_CTRL_1, 0, 1);
>> +
>> +                     udelay(200);
>> +                     xpsgtr_write_phy(gtr_phy, L0_BIST_CTRL_1, 0);
>> +                     packets = xpsgtr_read_phy(gtr_phy, L0_BIST_PKT_CTR_L);
>> +                     packets |= xpsgtr_read_phy(gtr_phy, L0_BIST_PKT_CTR_H)
>> << 8;
>> +                     errors = xpsgtr_read_phy(gtr_phy, L0_BIST_ERR_CTR_L);
>> +                     errors |= xpsgtr_read_phy(gtr_phy, L0_BIST_ERR_CTR_H)
>> << 8;
>> +                     ok[lane] = packets && !errors;
>> +
>> +                     dev_dbg(gtr_dev->dev,
>> +                             "lane %lu ILL %d packets %10u errors %10u\n",
>> +                             lane, i, packets, errors);
>> +             }
>> +
>> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0);
>> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x00);
>> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x02);
>> +
>> +             for_each_set_bit(lane, lanes, NUM_LANES) {
>> +                     pass[lane] += ok[lane] && last_ok[lane];
>> +                     if (pass[lane] < 4) {
>> +                             if (!ok[lane] && i > 2) {
>> +                                     if (altpass[lane] < pass[lane]) {
>> +                                             altpass[lane] = pass[lane];
>> +                                             altbest[lane] =
>> +                                                     (i - 1) - (pass[lane] + 1) / 2;
>> +                                     }
>> +                                     pass[lane] = 0;
>> +                             }
>> +                     } else if (!best[lane] && (!ok[lane] || i == 63) &&
>> +                                last_ok[lane]) {
>> +                             best[lane] = (i - 1) - (pass[lane] + 1) / 2;
>> +                     }
>> +             }
>> +
>> +             memcpy(last_ok, ok, sizeof(ok));
>> +     }
>> +
>> +     for_each_set_bit(lane, lanes, NUM_LANES) {
>> +             dev_dbg(gtr_dev->dev, "lane %lu ILL best %d alt best %d\n",
>> +                     lane, best[lane], altbest[lane]);
>> +
>> +             xpsgtr_phy_set_ill(&gtr_dev->phys[lane],
>> +                                best[lane] ?: altbest[lane], gen2);
>> +     }
>> +
>> +     /* Clean up */
>> +     xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_7, 0x30, 0);
>> +     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_2, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUN_LEN_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_INJ_POINT_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUNLEN_ERR_INJ_H, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_CHAR_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_IDLE_H, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_LOW_PULSE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TOTAL_PULSE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_1, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_2, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_3, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_4, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_MSBS, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_NUM, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FRM_IDLE_TIME, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_CTR_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_CTR_H, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_CTR_L, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_CTR_H, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FILLER_OUT, 1);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FORCE_MK_RST, 0);
>> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_DIG_22, 0);
>> +
>> +     for_each_set_bit(lane, lanes, NUM_LANES) {
>> +             struct xpsgtr_phy *gtr_phy = &gtr_dev->phys[lane];
>> +
>> +             xpsgtr_phy_init_bus_width(gtr_phy, PROT_BUS_WIDTH_20);
>> +             xpsgtr_phy_set_loopback(gtr_phy, false);
>> +     }
>> +}
>> +
>>  static int xpsgtr_common_init(struct xpsgtr_phy *gtr_phy)
>>  {
>>       int ret;
>> @@ -553,6 +875,37 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy
>> *gtr_phy)
>>  {
>>       struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>>
>> +     if (!xpsgtr_ill_calibrated(gtr_phy)) {
>> +             DECLARE_BITMAP(lanes, NUM_LANES) = { 0 };
>> +
>> +             xpsgtr_init_ill(gtr_phy);
>> +             xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL3, 100);
>> +             xpsgtr_clr_set_phy(gtr_phy, L0_TM_ILL11, 0xf0, 0x20);
>> +
>> +             __set_bit(gtr_phy->lane, lanes);
>> +             xpsgtr_phy_illcalib(gtr_dev, lanes, false);
>> +             xpsgtr_phy_set_ill(gtr_phy, 7, true);
>> +     }
>> +
>> +     /* Disable SSC */
>> +     xpsgtr_write_phy(gtr_phy, L0_PLL_FBDIV_FRAC_3_MSB,
>> TM_FORCE_EN_FRAC);
>> +     xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_3_MSB, 0,
>> TM_FORCE_EN);
>> +
>> +     /* Disable Tx deemphasis */
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_CDR5,
>> +                      FIELD_PREP(L0_TM_CDR5_FPHL_FSM_ACC_CYCLES,
>> 7) |
>> +                      FIELD_PREP(L0_TM_CDR5_FFL_PH0_INT_GAIN, 6));
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_CDR16, 12);
>> +
>> +     /* Configure equalization */
>> +     xpsgtr_write_phy(gtr_phy, L0_TX_ANA_TM_118,
>> +                      L0_TX_ANA_TM_118_FORCE_17_0);
>> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_EQ0, 0,
>> L0_TM_EQ0_EQ_STG2_CTRL_BYP);
>> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_EQ1,
>> L0_TM_EQ1_EQ_STG2_RL_PROG,
>> +                        FIELD_PREP(L0_TM_EQ1_EQ_STG2_RL_PROG, 2) |
>> +                        L0_TM_EQ1_EQ_STG2_PREAMP_MODE_VAL);
>> +     xpsgtr_write_phy(gtr_phy, L0_TX_ANA_TM_18, 2); /* -3.5 dB deemphasis */
>> +
>>       xpsgtr_bypass_scrambler_8b10b(gtr_phy);
>>
>>       writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
>> @@ -565,6 +918,64 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy
>> *gtr_phy)
>>       xpsgtr_bypass_scrambler_8b10b(gtr_phy);
>>  }
>>
>> +/* PCIe-specific initialization. */
>> +static int xpsgtr_phy_init_pcie(struct xpsgtr_phy *gtr_phy)
>> +{
>> +     struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>> +     DECLARE_BITMAP(lanes, NUM_LANES) = { 0 };
>> +     unsigned long lane;
>> +     bool calibrated = false;
>> +
>> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_AUX_0, 0, 0x20);
>> +
>> +     for (lane = 0; lane < NUM_LANES; lane++) {
>> +             struct xpsgtr_phy *gtr_phy = &gtr_dev->phys[lane];
>> +
>> +             if (gtr_phy->protocol != ICM_PROTOCOL_PCIE)
>> +                     continue;
>> +
>> +             __set_bit(lane, lanes);
>> +             calibrated = calibrated || xpsgtr_ill_calibrated(gtr_phy);
>> +     }
>> +
>> +     if (calibrated)
>> +             return 0;
>> +
>> +     /* Write default ILL config */
>> +     for_each_set_bit(lane, lanes, NUM_LANES) {
>> +             struct xpsgtr_phy *p = &gtr_dev->phys[lane];
>> +
>> +             if (lane != gtr_phy->lane) {
>> +                     int ret = xpsgtr_common_init(p);
>> +
>> +                     if (ret)
>> +                             return ret;
>> +             }
>> +
>> +             xpsgtr_init_ill(p);
>> +             xpsgtr_write_phy(p, L0_TM_E_ILL3, 0);
>> +             xpsgtr_clr_set_phy(p, L0_TM_MISC2, 0,
>> +                                L0_TM_MISC2_ILL_CAL_BYPASS);
>> +     }
>> +
>> +     /* Perform the ILL calibration procedure */
>> +     xpsgtr_phy_illcalib(gtr_dev, lanes, false);
>> +     xpsgtr_phy_illcalib(gtr_dev, lanes, true);
>> +
>> +     /* Disable PCIe ECO */
>> +     writel(1, gtr_dev->siou + SIOU_ECO_0);
>> +     return 0;
>> +}
>> +
>> +/* USB-specific initialization. */
>> +static void xpsgtr_phy_init_usb(struct xpsgtr_phy *gtr_phy)
>> +{
>> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_AUX_0, 0, 0x20);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL8, 0xf3);
>> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL8, 0xf3);
>> +     xpsgtr_phy_set_ill(gtr_phy, 7, false);
>> +}
>> +
>>  /* Configure TX de-emphasis and margining for DP. */
>>  static void xpsgtr_phy_configure_dp(struct xpsgtr_phy *gtr_phy, unsigned int pre,
>>                                   unsigned int voltage)
>> @@ -710,6 +1121,10 @@ static int xpsgtr_phy_init(struct phy *phy)
>>               xpsgtr_phy_init_dp(gtr_phy);
>>               break;
>>
>> +     case ICM_PROTOCOL_PCIE:
>> +             ret = xpsgtr_phy_init_pcie(gtr_phy);
>> +             break;
>> +
>>       case ICM_PROTOCOL_SATA:
>>               xpsgtr_phy_init_sata(gtr_phy);
>>               break;
>> @@ -717,6 +1132,10 @@ static int xpsgtr_phy_init(struct phy *phy)
>>       case ICM_PROTOCOL_SGMII:
>>               xpsgtr_phy_init_sgmii(gtr_phy);
>>               break;
>> +
>> +     case ICM_PROTOCOL_USB:
>> +             xpsgtr_phy_init_usb(gtr_phy);
>> +             break;
>>       }
>>
>>  out:
>> --
>> 2.35.1.1320.gc452695387.dirty
> 
