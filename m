Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795292076;
	b=lByPTIKynXjRQ18HRwok9V3ne7XvVXrT7CzOVd85Q1fNowqkg//fxmcJP225YDKfvt0n
	 yHn9bOuL1Wij5Q/8KqMhbYyWaAG5kaCzObzyn3n59q7Kw+QD4q2OXNpseBPfnyzVHuh8v
	 qGhJRKXrR1XZHAmRmmOMLOj8h9SI8hhMiEnFFNCiNXlyWsaK6c6VAyWGDhBlKtEbPCpIU
	 pOm+5D45xWURQc/jFBkE20ocU2WdwHVuOmueLT/wO7w4XSASqBhRNNpLH3A89GZf4v7tZ
	 FYcEFbu3kB62aAqTzjdl3XVLnoeVDuhNuVPGOnubEwQYicPHDSVSiEevyngJ2sI/19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795292076;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Wymb/zdax1lwvEAGFrTVnszhYDtvc2xBVyrnVA7YC/E=;
	b=OhZEAFDHZoK0xJJ+miGXou9vB6GB9lbXGxJ7FJFRKfg7hwNTXgH3fDJdYitH6Yfwre7D
	 DGIxn8HEtW/E9w44smHlQWsdAPxaEoq5rRFlkpG8UkINpf+THIVFMOEeLQ1Q2caG4APkn
	 C+LUcwvSmHfsiBmaUcV0AGqC9cyWK5oGVZtf3kxyoxm3C5Zxbrf67IDu8MYOWX/38Rh98
	 9RsaBSajAObkt/zrqDjphkMewOiFRt34nd3XrY4MTKnU5bamj1mKOwSi4AvG4udkMnAb+
	 xumPc6Aebsy/hP8D/JR8d5SORfU66HF6xMFCza7ZJBTPJPtjvC3OJ0CF990Q5iYy1aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwGXSLEH;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5CA606A320;
	Sat, 21 Nov 2026 20:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C5CA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwGXSLEH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795292075; x=1826828075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQqhK3CDxQ2TCoeosOjssQxc40BIibKL0Nf1TEi7e9s=;
  b=hwGXSLEHxhRWHDSxPxtf40TJpB2lBv5ulpUd/PHJjFh4nkcwu/2Ixxi6
   EnRlS4uI8EVchnGeAff4Xh8Y/i1Wa2xFOpA0zEPasZBINlO0GWRIUXuCD
   j5blFHgiIkxtLQ8Rq57ywjE9GQS7yRguq8bXQuislN/AMDWG53/Y6HOfw
   VZV8Qz4Dy/kt1vZh0jvJ3rp34EEXTKyemg9kQN/wrEu8SYudwB/Q1S2QD
   8DdULY0vA46vltyQI8ZcK9lA6hG59Tj023DMRbwgHApVbu+Sm2uVuFFW/
   ODseG0ojMo0TuFYWaOQTfRhDJ1TIgz+bmcx1hzRMvvS17qVFvmfS5nfhJ
   w==;
X-CSE-ConnectionGUID: QIiqjGeeQIav0gGtOKxPXQ==
X-CSE-MsgGUID: YatOFxXoRo6UHAWko8pCgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4036115"
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="4036115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 12:14:34 -0800
X-CSE-ConnectionGUID: CQc1idR5TAmn81Ok1QsCkQ==
X-CSE-MsgGUID: m/Xa18/DRmKteaF2PZ291g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="10748401"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Nov 2026 12:14:31 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUrTg-00000001KXr-3Hlq;
	Sat, 21 Nov 2026 20:14:28 +0000
Date: Sun, 22 Nov 2026 04:14:23 +0800
From: kernel test robot <lkp@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, "H . Peter Anvin" <hpa@zytor.com>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Subject: Re: [PATCH] PCI: Convert pci.c to pci_power_t helpers
Message-ID: <202611220427.bDq695TB-lkp@intel.com>
References: <20261121125811.50315-3-habilerenturker@hotmail.com>
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
In-Reply-To: <20261121125811.50315-3-habilerenturker@hotmail.com>

Hi Habil,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.4-rc3 next-20261119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Habil-Eren-T-rker/PCI-Convert-pci-c-to-pci_power_t-helpers/20261121-125915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20261121125811.50315-3-habilerenturker%40hotmail.com
patch subject: [PATCH] PCI: Convert pci.c to pci_power_t helpers
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261122/202611220427.bDq695TB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261122/202611220427.bDq695TB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611220427.bDq695TB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pci.c: In function 'pci_update_current_state':
>> drivers/pci/pci.c:1174:38: error: implicit declaration of function 'pci_power_t_get'; did you mean 'pci_power_name'? [-Wimplicit-function-declaration]
    1174 |                 dev->current_state = pci_power_t_get(pmcsr);
         |                                      ^~~~~~~~~~~~~~~
         |                                      pci_power_name
   drivers/pci/pci.c: In function 'pci_power_up':
>> drivers/pci/pci.c:1372:26: error: implicit declaration of function 'pci_power_t_eq'; did you mean 'pci_power_up'? [-Wimplicit-function-declaration]
    1372 |                         (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D3hot) ||
         |                          ^~~~~~~~~~~~~~
         |                          pci_power_up
   drivers/pci/pci.c: In function 'pci_set_low_power_state':
>> drivers/pci/pci.c:1548:9: error: implicit declaration of function 'pci_power_t_set'; did you mean 'pci_power_name'? [-Wimplicit-function-declaration]
    1548 |         pci_power_t_set(&pmcsr, state);
         |         ^~~~~~~~~~~~~~~
         |         pci_power_name


vim +1174 drivers/pci/pci.c

  1149	
  1150	/**
  1151	 * pci_update_current_state - Read power state of given device and cache it
  1152	 * @dev: PCI device to handle.
  1153	 * @state: State to cache in case the device doesn't have the PM capability
  1154	 *
  1155	 * The power state is read from the PMCSR register, which however is
  1156	 * inaccessible in D3cold.  The platform firmware is therefore queried first
  1157	 * to detect accessibility of the register.  In case the platform firmware
  1158	 * reports an incorrect state or the device isn't power manageable by the
  1159	 * platform at all, we try to detect D3cold by testing accessibility of the
  1160	 * vendor ID in config space.
  1161	 */
  1162	void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
  1163	{
  1164		if (platform_pci_get_power_state(dev) == PCI_D3cold) {
  1165			dev->current_state = PCI_D3cold;
  1166		} else if (dev->pm_cap) {
  1167			u16 pmcsr;
  1168	
  1169			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
  1170			if (PCI_POSSIBLE_ERROR(pmcsr)) {
  1171				dev->current_state = PCI_D3cold;
  1172				return;
  1173			}
> 1174			dev->current_state = pci_power_t_get(pmcsr);
  1175		} else {
  1176			dev->current_state = state;
  1177		}
  1178	}
  1179	
  1180	/**
  1181	 * pci_refresh_power_state - Refresh the given device's power state data
  1182	 * @dev: Target PCI device.
  1183	 *
  1184	 * Ask the platform to refresh the devices power state information and invoke
  1185	 * pci_update_current_state() to update its current PCI power state.
  1186	 */
  1187	void pci_refresh_power_state(struct pci_dev *dev)
  1188	{
  1189		platform_pci_refresh_power_state(dev);
  1190		pci_update_current_state(dev, dev->current_state);
  1191	}
  1192	
  1193	/**
  1194	 * pci_platform_power_transition - Use platform to change device power state
  1195	 * @dev: PCI device to handle.
  1196	 * @state: State to put the device into.
  1197	 */
  1198	int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
  1199	{
  1200		int error;
  1201	
  1202		error = platform_pci_set_power_state(dev, state);
  1203		if (!error)
  1204			pci_update_current_state(dev, state);
  1205		else if (!dev->pm_cap) /* Fall back to PCI_D0 */
  1206			dev->current_state = PCI_D0;
  1207	
  1208		return error;
  1209	}
  1210	EXPORT_SYMBOL_GPL(pci_platform_power_transition);
  1211	
  1212	static int pci_resume_one(struct pci_dev *pci_dev, void *ign)
  1213	{
  1214		pm_request_resume(&pci_dev->dev);
  1215		return 0;
  1216	}
  1217	
  1218	/**
  1219	 * pci_resume_bus - Walk given bus and runtime resume devices on it
  1220	 * @bus: Top bus of the subtree to walk.
  1221	 */
  1222	void pci_resume_bus(struct pci_bus *bus)
  1223	{
  1224		if (bus)
  1225			pci_walk_bus(bus, pci_resume_one, NULL);
  1226	}
  1227	
  1228	static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  1229	{
  1230		int delay = 1;
  1231		bool retrain = false;
  1232		struct pci_dev *root, *bridge;
  1233	
  1234		root = pcie_find_root_port(dev);
  1235	
  1236		if (pci_is_pcie(dev)) {
  1237			bridge = pci_upstream_bridge(dev);
  1238			if (bridge)
  1239				retrain = true;
  1240		}
  1241	
  1242		/*
  1243		 * The caller has already waited long enough after a reset that the
  1244		 * device should respond to config requests, but it may respond
  1245		 * with Request Retry Status (RRS) if it needs more time to
  1246		 * initialize.
  1247		 *
  1248		 * If the device is below a Root Port with Configuration RRS
  1249		 * Software Visibility enabled, reading the Vendor ID may return a
  1250		 * special data value if the device responded with RRS.  Read the
  1251		 * Vendor ID until we get non-RRS status and something other than
  1252		 * ~0.  The Vendor ID of VFs reads ~0, so check their Command
  1253		 * register instead.
  1254		 *
  1255		 * If there's no Root Port or Configuration RRS Software Visibility
  1256		 * is not enabled, the device may still respond with RRS, but
  1257		 * hardware may retry the config request.  If no retries receive
  1258		 * Successful Completion, hardware generally synthesizes ~0
  1259		 * (PCI_ERROR_RESPONSE) data to complete the read.  Reading Vendor
  1260		 * ID for VFs and non-existent devices also returns ~0, so read the
  1261		 * Command register until it returns something other than ~0.
  1262		 */
  1263		for (;;) {
  1264			u32 id;
  1265	
  1266			if (pci_dev_is_disconnected(dev)) {
  1267				pci_dbg(dev, "disconnected; not waiting\n");
  1268				return -ENOTTY;
  1269			}
  1270	
  1271			if (root && root->config_rrs_sv) {
  1272				pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
  1273				if (!pci_bus_rrs_vendor_id(id)) {
  1274					if (PCI_POSSIBLE_ERROR(id) && dev->is_virtfn)
  1275						pci_read_config_dword(dev, PCI_COMMAND,
  1276								      &id);
  1277					if (!PCI_POSSIBLE_ERROR(id))
  1278						break;
  1279				}
  1280			} else {
  1281				pci_read_config_dword(dev, PCI_COMMAND, &id);
  1282				if (!PCI_POSSIBLE_ERROR(id))
  1283					break;
  1284			}
  1285	
  1286			if (delay > timeout) {
  1287				pci_err(dev, "not ready %dms after %s; giving up\n",
  1288					delay - 1, reset_type);
  1289				return -ENOTTY;
  1290			}
  1291	
  1292			if (delay > PCI_RESET_WAIT) {
  1293				if (retrain) {
  1294					retrain = false;
  1295					if (pcie_failed_link_retrain(bridge) == 0) {
  1296						delay = 1;
  1297						continue;
  1298					}
  1299				}
  1300				pci_info(dev, "not ready %dms after %s; waiting\n",
  1301					 delay - 1, reset_type);
  1302			}
  1303	
  1304			msleep(delay);
  1305			delay *= 2;
  1306		}
  1307	
  1308		if (delay > PCI_RESET_WAIT)
  1309			pci_info(dev, "ready %dms after %s\n", delay - 1,
  1310				 reset_type);
  1311		else
  1312			pci_dbg(dev, "ready %dms after %s\n", delay - 1,
  1313				reset_type);
  1314	
  1315		return 0;
  1316	}
  1317	
  1318	/**
  1319	 * pci_power_up - Put the given device into D0
  1320	 * @dev: PCI device to power up
  1321	 *
  1322	 * On success, return 0 or 1, depending on whether or not it is necessary to
  1323	 * restore the device's BARs subsequently (1 is returned in that case).
  1324	 *
  1325	 * On failure, return a negative error code.  Always return failure if @dev
  1326	 * lacks a Power Management Capability, even if the platform was able to
  1327	 * put the device in D0 via non-PCI means.
  1328	 */
  1329	int pci_power_up(struct pci_dev *dev)
  1330	{
  1331		bool need_restore;
  1332		pci_power_t state;
  1333		u16 pmcsr;
  1334		int ret;
  1335	
  1336		/*
  1337		 * When setting power state to D0, platform_pci_set_power_state()
  1338		 * ensures main power is on.  If it puts the device in D0, it also
  1339		 * completes any required delays after the transition; if it leaves
  1340		 * the device in D1, D2, or D3hot, we use the PM Capability to
  1341		 * transition to D0.
  1342		 *
  1343		 * In all cases, the device is either Configuration-Ready or
  1344		 * inaccessible upon return.
  1345		 */
  1346		platform_pci_set_power_state(dev, PCI_D0);
  1347	
  1348		if (!dev->pm_cap) {
  1349			state = platform_pci_get_power_state(dev);
  1350			if (state == PCI_UNKNOWN)
  1351				dev->current_state = PCI_D0;
  1352			else
  1353				dev->current_state = state;
  1354	
  1355			return -EIO;
  1356		}
  1357	
  1358		if (pci_dev_is_disconnected(dev)) {
  1359			dev->current_state = PCI_D3cold;
  1360			return -EIO;
  1361		}
  1362	
  1363		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
  1364		if (PCI_POSSIBLE_ERROR(pmcsr)) {
  1365			pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
  1366				pci_power_name(dev->current_state));
  1367			dev->current_state = PCI_D3cold;
  1368			return -EIO;
  1369		}
  1370	
  1371		need_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> 1372				(pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D3hot) ||
  1373				dev->current_state >= PCI_D3hot);
  1374	
  1375		if (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D0))
  1376			goto end;
  1377	
  1378		/*
  1379		 * Force the entire word to 0. This doesn't affect PME_Status, disables
  1380		 * PME_En, and sets PowerState to 0.
  1381		 */
  1382		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
  1383	
  1384		/* Mandatory transition delays; see PCI PM 1.2. */
  1385		if (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D3hot)) {
  1386			pci_dev_d3_sleep(dev);
  1387			if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
  1388				ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
  1389						   PCIE_RESET_READY_POLL_MS);
  1390				if (ret) {
  1391					dev->current_state = PCI_D3cold;
  1392					return -EIO;
  1393				}
  1394			}
  1395		} else if (pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D2)) {
  1396			udelay(PCI_PM_D2_DELAY);
  1397		}
  1398	
  1399	end:
  1400		dev->current_state = PCI_D0;
  1401		if (need_restore)
  1402			return 1;
  1403	
  1404		return 0;
  1405	}
  1406	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
