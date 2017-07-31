Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdGaFk0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2017 01:40:26 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        smuthayy <smuthayy@codeaurora.org>
Subject: [PATCH v5 4/7] phy: qcom-qmp: Add support for IPQ8074
Date: Mon, 31 Jul 2017 11:09:51 +0530
Message-Id: <1501479594-18285-5-git-send-email-varada@codeaurora.org>
In-Reply-To: <1501479594-18285-1-git-send-email-varada@codeaurora.org>
References: <1501479594-18285-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add definitions required to enable QMP phy support for IPQ8074.

Signed-off-by: smuthayy <smuthayy@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 464049c..136d236 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -59,6 +59,7 @@
 #define QSERDES_COM_PLL_RCTRL_MODE1			0x088
 #define QSERDES_COM_PLL_CCTRL_MODE0			0x090
 #define QSERDES_COM_PLL_CCTRL_MODE1			0x094
+#define QSERDES_COM_BIAS_EN_CTRL_BY_PSM			0x0a8
 #define QSERDES_COM_SYSCLK_EN_SEL			0x0ac
 #define QSERDES_COM_RESETSM_CNTRL			0x0b4
 #define QSERDES_COM_RESTRIM_CTRL			0x0bc
@@ -143,6 +144,11 @@
 #define QPHY_LOCK_DETECT_CONFIG3			0x88
 #define QPHY_PWRUP_RESET_DLY_TIME_AUXCLK		0xa0
 #define QPHY_LP_WAKEUP_DLY_TIME_AUXCLK			0xa4
+#define QPHY_PLL_LOCK_CHK_DLY_TIME_AUXCLK_LSB		0x1A8
+#define QPHY_OSC_DTCT_ACTIONS				0x1AC
+#define QPHY_RX_SIGDET_LVL				0x1D8
+#define QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB		0x1DC
+#define QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB		0x1E0
 
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
@@ -382,6 +388,85 @@ enum qphy_reg_layout {
 	QMP_PHY_INIT_CFG(QPHY_POWER_STATE_CONFIG2, 0x08),
 };
 
+static const struct qmp_phy_init_tbl ipq8074_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0xf),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER1, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x6),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0xf),
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x3),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0xD),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xD04),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x33),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_BUF_ENABLE, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0xb),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CTRL_BY_PSM, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0xa),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_PER2, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE1, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_STEP_SIZE2, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_EP_DIV, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x7),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x6),
+	QMP_PHY_INIT_CFG(QSERDES_TX_RES_CODE_LANE_OFFSET, 0x2),
+	QMP_PHY_INIT_CFG(QSERDES_TX_RCV_DETECT_LVL_2, 0x12),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3, 0x0),
+	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN, 0x4),
+	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_GAIN_HALF, 0x4),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_ENDPOINT_REFCLK_DRIVE, 0x4),
+	QMP_PHY_INIT_CFG(QPHY_OSC_DTCT_ACTIONS, 0x0),
+	QMP_PHY_INIT_CFG(QPHY_PWRUP_RESET_DLY_TIME_AUXCLK, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB, 0x0),
+	QMP_PHY_INIT_CFG(QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_PLL_LOCK_CHK_DLY_TIME_AUXCLK_LSB, 0x0),
+	QMP_PHY_INIT_CFG(QPHY_LP_WAKEUP_DLY_TIME_AUXCLK, 0x40),
+	QMP_PHY_INIT_CFG_L(QPHY_PLL_LOCK_CHK_DLY_TIME, 0x73),
+	QMP_PHY_INIT_CFG(QPHY_RX_SIGDET_LVL, 0x99),
+	QMP_PHY_INIT_CFG(QPHY_TXDEEMPH_M6DB_V0, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_TXDEEMPH_M3P5DB_V0, 0xe),
+	QMP_PHY_INIT_CFG_L(QPHY_SW_RESET, 0x0),
+	QMP_PHY_INIT_CFG_L(QPHY_START_CTRL, 0x3),
+};
+
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
 	/* phy-type - PCIE/UFS/USB */
@@ -580,6 +665,42 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.mask_pcs_ready		= PHYSTATUS,
 };
 
+/* list of resets */
+static const char * const ipq8074_pciephy_reset_l[] = {
+	"phy", "common",
+};
+
+static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
+	.type			= PHY_TYPE_PCIE,
+	.nlanes			= 1,
+
+	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
+	.tx_tbl			= ipq8074_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_tx_tbl),
+	.rx_tbl			= ipq8074_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(ipq8074_pcie_rx_tbl),
+	.pcs_tbl		= ipq8074_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_pcie_pcs_tbl),
+	.clk_list		= NULL,
+	.num_clks		= 0,
+	.reset_list		= ipq8074_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
+	.vreg_list		= NULL,
+	.num_vregs		= 0,
+	.regs			= pciephy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.mask_pcs_ready		= PHYSTATUS,
+
+	.has_phy_com_ctrl	= false,
+	.has_lane_rst		= false,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static void qcom_qmp_phy_configure(void __iomem *base,
 				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
@@ -1048,6 +1169,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	}, {
 		.compatible = "qcom,msm8996-qmp-usb3-phy",
 		.data = &msm8996_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,ipq8074-qmp-pcie-phy",
+		.data = &ipq8074_pciephy_cfg,
 	},
 	{ },
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
