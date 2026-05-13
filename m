Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A8374E5A;
	Wed, 13 May 2026 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654388; cv=none; b=rUdM7b6olelbkl5Mu5P5irxio+GGtFXMwDNXor2uBY3qV7bSCLvdVUJXQ6HJOKufp9zPB3E3znRiXjFwLuekf7fyT6ANDWsVrIFBhXDuhHLE4XUYI2bSpVaBfa6ngGXkPD/ZIgo7VWmnNn1hVZChhlbeVpCO2Iz/gr9qEPzJwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654388; c=relaxed/simple;
	bh=DIMiz/LCbeO/gUtCDuKrM9cbz2f+9jcRxksoFlsLuOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBaaZ49sGUVXUwLWafMmoSDaUx3LyEOOPzLl0l6s6njIG4PUzEOx6FK2dp7z7/WQnBa/WHRx4RYZZUhFPQCD8DyCzoLI4QwIXYQ7wWxznuOuVUJjhkInaMg0LL0JbWlibalxccUPZZZNDNjc2j39734a6RRvrmjsYpV2FiYEzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CyJtOCqU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CyJtOCqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=TcUUfkJUVIebURdxsafTNxsRNHwxk2ULncnOIreCEhY=;
	b=CyJtOCqU5zp19mYQEfaw2j7d7IoyEsvoNYlGY9SAZs3BrjRC+obo1LM9aCH/uw
	yHIPr6CNMal0VM4yp5fNugSKIFkYpU7xbO/RFj2SD0zzUf0ONpIN7aJqYwNHKY3V
	mUrPmpIzra71eoUIailCHfSBAT7gPby7nAurr/WqO+bcs=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3t4SRHARq3htRBA--.13912S2;
	Wed, 13 May 2026 14:39:14 +0800 (CST)
Message-ID: <291e0ab2-4967-420e-b4f8-34284b9d70ff@163.com>
Date: Wed, 13 May 2026 14:39:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 Aksh Garg <a-garg7@ti.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>,
 "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3t4SRHARq3htRBA--.13912S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3tr45CF4DGF48Ar48CF4rXwb_yoWDZF4Dpr
	y8JFWvvF42vw13AFWYy3W8WF45Ja4SyFn8Cr4DWrW8Cas7uFnrWr15tr1DCrZ5Jr17Wrnx
	Jw1ayF1SkFs5ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeVbkUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BLGamoEHJLU+wAA3d



On 5/13/26 14:11, Manikandan Karunakaran Pillai wrote:
>> On 08/05/26 09:11, Hans Zhang wrote:
>>> Add the debugfs property to provide a view of the current link's LTSSM
>>> status from the Root Port device.
>>>
>>> Test example:
>>>     # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>>>     L0_STATE (0x29)
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>    Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>>>    drivers/pci/controller/cadence/Kconfig        |   9 +
>>>    drivers/pci/controller/cadence/Makefile       |   1 +
>>>    drivers/pci/controller/cadence/pci-sky1.c     |   3 +
>>>    .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
>>>    .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
>>>    .../cadence/pcie-cadence-host-hpa.c           |  20 +-
>>>    .../controller/cadence/pcie-cadence-host.c    |   9 +-
>>>    drivers/pci/controller/cadence/pcie-cadence.h | 150 +++++++++++++
>>>    9 files changed, 406 insertions(+), 2 deletions(-)
>>>    create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>>>    create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>
>>> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie
>> b/Documentation/ABI/testing/debugfs-cdns-pcie
>>> new file mode 100644
>>> index 000000000000..659ad2ab70e4
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
>>> @@ -0,0 +1,5 @@
>>> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
>>> +Date:		March 2026
>>> +Contact:	Hans Zhang <18255117159@163.com>
>>> +Description:	(RO) Read will return the current PCIe LTSSM state in both
>>> +		string and raw value.
>>> diff --git a/drivers/pci/controller/cadence/Kconfig
>> b/drivers/pci/controller/cadence/Kconfig
>>> index 9e651d545973..cb010bc97aad 100644
>>> --- a/drivers/pci/controller/cadence/Kconfig
>>> +++ b/drivers/pci/controller/cadence/Kconfig
>>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>>    config PCIE_CADENCE
>>>    	tristate
>>>
>>> +config PCIE_CADENCE_DEBUGFS
>>> +	tristate "Cadence PCIe debugfs entries"
>>> +	depends on DEBUG_FS
>>> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
>>> +	help
>>> +	  Say Y here to enable debugfs entries for the PCIe controller. These
>>> +	  entries provide various debug features related to the controller and
>>> +	  the LTSSM status of link can be displayed.
>>> +
>>>    config PCIE_CADENCE_HOST
>>>    	tristate
>>>    	depends on OF
>>
>> [...]
>>
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
>> b/drivers/pci/controller/cadence/pcie-cadence.h
>>> index 9a464cbaf073..a1c531fd2061 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>> @@ -42,6 +42,137 @@ enum cdns_pcie_reg_bank {
>>>    	REG_BANKS_MAX,
>>>    };
>>>
>>> +enum cdns_pcie_ltssm {
>>> +	CDNS_PCIE_LTSSM_DETECT_QUIET		= 0,
>>> +	CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY	= 1,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE		= 2,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_1		= 3,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_2		= 4,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_3		= 5,
>>> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_ST	= 6,
>>> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_1		= 7,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE		= 8,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_1	= 9,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_2	= 10,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_3	= 11,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE	= 12,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1	= 13,
>>> +	CDNS_PCIE_LTSSM_POLLING_CONFIG		= 14,
>>> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_1	= 15,
>>> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_2	= 16,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC	= 17,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1	= 18,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2	= 19,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC	= 20,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC	= 21,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1 = 22,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC	= 23,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP	= 24,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1	= 25,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2	= 26,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP	= 27,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP	= 28,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1 = 29,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP	= 30,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1	= 31,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_1		= 32,
>>> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE		= 33,
>>> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1	= 34,
>>> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2	= 35,
>>> +	CDNS_PCIE_LTSSM_CONFIG_IDLE		= 36,
>>> +	CDNS_PCIE_LTSSM_CONFIG_IDLE_1		= 37,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_2		= 38,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_3		= 39,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_4		= 40,
>>> +	CDNS_PCIE_LTSSM_L0_STATE		= 41,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK	= 42,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1	= 43,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG	= 44,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1	= 45,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE		= 46,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE_1		= 47,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK		= 48,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_1		= 49,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_2		= 50,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_3		= 51,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_4		= 52,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_5		= 53,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_6		= 54,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_7		= 55,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET		= 56,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET_1		= 57,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET_2		= 58,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET_3		= 59,
>>> +	CDNS_PCIE_LTSSM_L0S_ENTRY		= 60,
>>> +	CDNS_PCIE_LTSSM_L0S_1			= 61,
>>> +	CDNS_PCIE_LTSSM_L0S_2			= 62,
>>> +	CDNS_PCIE_LTSSM_L0S_3			= 63,
>>> +	CDNS_PCIE_LTSSM_L0S_4			= 64,
>>> +	CDNS_PCIE_LTSSM_L0S_5			= 65,
>>> +	CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX	= 66,
>>> +	CDNS_PCIE_LTSSM_TX_FTS_ENTRY		= 67,
>>> +	CDNS_PCIE_LTSSM_TX_FTS_1		= 68,
>>> +	CDNS_PCIE_LTSSM_TX_FTS_2		= 69,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST		= 70,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1		= 71,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2		= 72,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3		= 73,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED		= 74,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_1	= 75,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_2	= 76,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_3	= 77,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23 = 78,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1 = 79,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2 = 80,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3 = 81,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4 = 82,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5 = 83,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6 = 84,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7 = 85,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8 = 86,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY	= 87,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1	= 89,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT	= 90,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1	= 91,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2	= 92,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3	= 93,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4	= 94,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5	= 95,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE	= 96,
>>> +	CDNS_PCIE_LTSSM_L1_ENTRY		= 97,
>>> +	CDNS_PCIE_LTSSM_L1_1			= 98,
>>> +	CDNS_PCIE_LTSSM_L1_2			= 99,
>>> +	CDNS_PCIE_LTSSM_L1_3			= 100,
>>> +	CDNS_PCIE_LTSSM_L1_4			= 101,
>>> +	CDNS_PCIE_LTSSM_L1_IDLE			= 102,
>>> +	CDNS_PCIE_LTSSM_L1_EXIT			= 103,
>>> +	CDNS_PCIE_LTSSM_L2_ENTRY		= 104,
>>> +	CDNS_PCIE_LTSSM_L2_1			= 105,
>>> +	CDNS_PCIE_LTSSM_L2_2			= 106,
>>> +	CDNS_PCIE_LTSSM_L2_3			= 107,
>>> +	CDNS_PCIE_LTSSM_L2_4			= 108,
>>> +	CDNS_PCIE_LTSSM_L2_5			= 109,
>>> +	CDNS_PCIE_LTSSM_L2_IDLE			= 110,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY	= 111,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1	= 112,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2	= 113,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3	= 114,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4	= 115,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5	= 116,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY =
>> 117,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE	= 118,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT	= 119,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1	= 120,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2	= 121,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
>>> +};
>>
> 
> The above LTSSM states are internal LTSSM encoding states and may not be available for software to use.
> The LTSSM states in the document pointed by Aksh (TI Soc) are the states  available in all cadence controllers.

Hi Manikandan,

For LGA IP, can't the registers be read out through the common registers 
of Cadence IP? Just like the approach of DWC. And the HPA IP is readable.


Best regards,
Hans

> 
>> Hi Hans,
>>
>> The LTSSM state encoding in your patches do not align with the state
>> encodings for LGA IP. TI SoCs have LGA IP of Cadence PCIe, and when I
>> applied your patches, the LTSSM value in the debugfs for the PCIe
>> subsystem (which have an EP connected to it) came out to be 0x10, which
>> points to the state "PCIE_L0". However, the debugfs prints the state as
>> "POLLING_CONFIG_2 (0x10)", which seems to be incorrect.
>>
>> The LTSSM state encodings for TI SoCs using Cadence PCIe IP is provided
>> in the J7200 TRM section 12.2.3.4.14 at:
>> https://urldefense.com/v3/__https://www.ti.com/lit/pdf/spruiu1__;!!EHscmS1
>> ygiU1lA!AudWpZJoYT3_nfvc33jiZrUFh75KB4DU-
>> na_9SNZTib3etI9BNC3Jq8RlPxVouCPY2Rt7SyqrNI$
>>
>> Regards,
>> Aksh Garg
>>
>>
>>> +
>>>    struct cdns_pcie_ops {
>>
> 

