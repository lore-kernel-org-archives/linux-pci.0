Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C41E8320;
	Thu, 19 Feb 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771495624; cv=none; b=G4/vbYPjUAaa00pTT49W9mTKPT63kcDGv4DqjviP4IDsbFIV2fTOfAS8T1MAPIgsYnJBRbgpNoS0WWmOjN5AVbpLd9Z2Rk1aQSrbX180c7PmFOZ5AZ+ISl23NKqwMS5h5SkT4iPtYXVY3sQ2QMn3nEdrkcUe8/WwTsZKOfCNV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771495624; c=relaxed/simple;
	bh=Wc3fKaIj0pI6pvOFf1BxY0Aba8TW85ti/78eaoZpRbs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coT6BhHWTPSJcKv8AQsURX3Ml0RUpvWGgVx0T0VWrzUPkQVGp8FkMDvP1+6Evh5fnywYqbO5Fxk9fpbmh1+SSF3BlH+EtIPuEeQvpWYfevUYvj7RGrkNBhDzPurbgFF7i9yhkglU1T5qPS9Em6yHGFlUde65WL6zdyQP3M9uQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fGptk2215zHnGhb;
	Thu, 19 Feb 2026 18:06:22 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 223E940572;
	Thu, 19 Feb 2026 18:06:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Feb
 2026 10:06:51 +0000
Date: Thu, 19 Feb 2026 10:06:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Besar Wicaksono <bwicaksono@nvidia.com>
CC: <will@kernel.org>, <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
	<ilkka@os.amperecomputing.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<mark.rutland@arm.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <sdonthineni@nvidia.com>,
	<skelley@nvidia.com>, <ywan@nvidia.com>, <mochs@nvidia.com>,
	<nirmoyd@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Yushan Wang <wangyushan12@huawei.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 4/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU
Message-ID: <20260219100649.000062ed@huawei.com>
In-Reply-To: <20260218145809.1622856-5-bwicaksono@nvidia.com>
References: <20260218145809.1622856-1-bwicaksono@nvidia.com>
	<20260218145809.1622856-5-bwicaksono@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 18 Feb 2026 14:58:05 +0000
Besar Wicaksono <bwicaksono@nvidia.com> wrote:

> Adds PCIE PMU support in Tegra410 SOC. This PMU is instanced
> in each root complex in the SOC and can capture traffic from
> PCIE device to various memory types. This PMU can filter traffic
> based on the originating root port or BDF and the target memory
> types (CPU DRAM, GPU Memory, CXL Memory, or remote Memory).
> 
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Given I've added a bunch of +CC I've left all your patch in place rather
than cropping to just what I've commented on.

Great to see another PCIe related PMU, but this is certainly showing
the diversity in what such things are!

I've expressed a few times that it would be really nice if a standard
PCI centric defintion would come from the PCI-SIG (similar to the one
that CXL has) but what you have here is, I think, monitoring certainly
types of accesses closer to the CPU interconnect side of the RC than
such a spec would cover.  As mentioned below I've +CC various people who
will be interested in this. Please keep them cc'd on v3.

> ---
>  .../admin-guide/perf/nvidia-tegra410-pmu.rst  | 162 ++++++++++++++
>  drivers/perf/arm_cspmu/nvidia_cspmu.c         | 211 +++++++++++++++++-
>  2 files changed, 368 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> index 7b7ba5700ca1..8528685ddb61 100644
> --- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> +++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> @@ -6,6 +6,7 @@ The NVIDIA Tegra410 SoC includes various system PMUs to measure key performance
>  metrics like memory bandwidth, latency, and utilization:
>  
>  * Unified Coherence Fabric (UCF)
> +* PCIE

It's interesting to see what people put in their PCIe related PMUs.
Seems we are getting a bit of a split into those focused on the SoC side of the host bridge
and those focused on the PCI protocol stuff (so counting TLPs, FLITs, Retries etc).

I don't suppose it matters that much, but maybe we need to think about some suitable
terminology..

I've +CC linux-pci and Bjorn as those are the folk who are most likely to comment
on generalization aspects of PCIe PMUs.
>  
>  PMU Driver
>  ----------
> @@ -104,3 +105,164 @@ Example usage:
>    destination filter = remote memory::
>  
>      perf stat -a -e nvidia_ucf_pmu_1/event=0x0,src_loc_noncpu=0x1,dst_rem=0x1/
> +
> +PCIE PMU
> +--------
> +
> +This PMU monitors all read/write traffic from the root port(s) or a particular
> +BDF in a PCIE root complex (RC) to local or remote memory. There is one PMU per
> +PCIE RC in the SoC. Each RC can have up to 16 lanes that can be bifurcated into
> +up to 8 root ports. The traffic from each root port can be filtered using RP or
> +BDF filter. For example, specifying "src_rp_mask=0xFF" means the PMU counter will
> +capture traffic from all RPs. Please see below for more details.
> +
> +The events and configuration options of this PMU device are described in sysfs,
> +see /sys/bus/event_source/devices/nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-id>.
> +
> +The events in this PMU can be used to measure bandwidth, utilization, and
> +latency:
> +
> +  * rd_req: count the number of read requests by PCIE device.
> +  * wr_req: count the number of write requests by PCIE device.
> +  * rd_bytes: count the number of bytes transferred by rd_req.
> +  * wr_bytes: count the number of bytes transferred by wr_req.
> +  * rd_cum_outs: count outstanding rd_req each cycle.
> +  * cycles: counts the PCIE cycles.

This maybe needs a tighter definition.  Too many types of cycle
involved in PCIe IPs.

Would also be good to see how this driver fits with the efforts for
a generic perf iostat
https://lore.kernel.org/all/20260126123514.3238425-1-wangyushan12@huawei.com/

(Added wangyushan and shiju to +CC)

> +
> +The average bandwidth is calculated as::
> +
> +   AVG_RD_BANDWIDTH_IN_GBPS = RD_BYTES / ELAPSED_TIME_IN_NS
> +   AVG_WR_BANDWIDTH_IN_GBPS = WR_BYTES / ELAPSED_TIME_IN_NS
> +
> +The average request rate is calculated as::
> +
> +   AVG_RD_REQUEST_RATE = RD_REQ / CYCLES
> +   AVG_WR_REQUEST_RATE = WR_REQ / CYCLES
> +
> +
> +The average latency is calculated as::
> +
> +   FREQ_IN_GHZ = CYCLES / ELAPSED_TIME_IN_NS
> +   AVG_LATENCY_IN_CYCLES = RD_CUM_OUTS / RD_REQ
> +   AVERAGE_LATENCY_IN_NS = AVG_LATENCY_IN_CYCLES / FREQ_IN_GHZ
> +
> +The PMU events can be filtered based on the traffic source and destination.
> +The source filter indicates the PCIE devices that will be monitored. The
> +destination filter specifies the destination memory type, e.g. local system
> +memory (CMEM), local GPU memory (GMEM), or remote memory. The local/remote
> +classification of the destination filter is based on the home socket of the
> +address, not where the data actually resides. These filters can be found in
> +/sys/bus/event_source/devices/nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-id>/format/.
> +
> +The list of event filters:
> +
> +* Source filter:
> +
> +  * src_rp_mask: bitmask of root ports that will be monitored. Each bit in this
> +    bitmask represents the RP index in the RC. If the bit is set, all devices under
> +    the associated RP will be monitored. E.g "src_rp_mask=0xF" will monitor
> +    devices in root port 0 to 3.
> +  * src_bdf: the BDF that will be monitored. This is a 16-bit value that
> +    follows formula: (bus << 8) + (device << 3) + (function). For example, the
> +    value of BDF 27:01.1 is 0x2781.
> +  * src_bdf_en: enable the BDF filter. If this is set, the BDF filter value in
> +    "src_bdf" is used to filter the traffic.
> +
> +  Note that Root-Port and BDF filters are mutually exclusive and the PMU in
> +  each RC can only have one BDF filter for the whole counters. If BDF filter
> +  is enabled, the BDF filter value will be applied to all events.
> +
> +* Destination filter:
> +
> +  * dst_loc_cmem: if set, count events to local system memory (CMEM) address
> +  * dst_loc_gmem: if set, count events to local GPU memory (GMEM) address
> +  * dst_loc_pcie_p2p: if set, count events to local PCIE peer address
> +  * dst_loc_pcie_cxl: if set, count events to local CXL memory address
> +  * dst_rem: if set, count events to remote memory address
> +
> +If the source filter is not specified, the PMU will count events from all root
> +ports. If the destination filter is not specified, the PMU will count events
> +to all destinations.
> +
> +Example usage:
> +
> +* Count event id 0x0 from root port 0 of PCIE RC-0 on socket 0 targeting all
> +  destinations::
> +
> +    perf stat -a -e nvidia_pcie_pmu_0_rc_0/event=0x0,src_rp_mask=0x1/
> +
> +* Count event id 0x1 from root port 0 and 1 of PCIE RC-1 on socket 0 and
> +  targeting just local CMEM of socket 0::
> +
> +    perf stat -a -e nvidia_pcie_pmu_0_rc_1/event=0x1,src_rp_mask=0x3,dst_loc_cmem=0x1/
> +
> +* Count event id 0x2 from root port 0 of PCIE RC-2 on socket 1 targeting all
> +  destinations::
> +
> +    perf stat -a -e nvidia_pcie_pmu_1_rc_2/event=0x2,src_rp_mask=0x1/
> +
> +* Count event id 0x3 from root port 0 and 1 of PCIE RC-3 on socket 1 and
> +  targeting just local CMEM of socket 1::
> +
> +    perf stat -a -e nvidia_pcie_pmu_1_rc_3/event=0x3,src_rp_mask=0x3,dst_loc_cmem=0x1/
> +
> +* Count event id 0x4 from BDF 01:01.0 of PCIE RC-4 on socket 0 targeting all
> +  destinations::
> +
> +    perf stat -a -e nvidia_pcie_pmu_0_rc_4/event=0x4,src_bdf=0x0180,src_bdf_en=0x1/
> +
> +Mapping the RC# to lspci segment number can be non-trivial; hence a new NVIDIA
> +Designated Vendor Specific Capability (DVSEC) register is added into the PCIE config space
> +for each RP. This DVSEC has vendor id "10de" and DVSEC id of "0x4". The DVSEC register
> +contains the following information to map PCIE devices under the RP back to its RC# :
> +
> +  - Bus# (byte 0xc) : bus number as reported by the lspci output
> +  - Segment# (byte 0xd) : segment number as reported by the lspci output
> +  - RP# (byte 0xe) : port number as reported by LnkCap attribute from lspci for a device with Root Port capability
> +  - RC# (byte 0xf): root complex number associated with the RP
> +  - Socket# (byte 0x10): socket number associated with the RP
> +
> +Example script for mapping lspci BDF to RC# and socket#::
> +
> +  #!/bin/bash
> +  while read bdf rest; do
> +    dvsec4_reg=$(lspci -vv -s $bdf | awk '
> +      /Designated Vendor-Specific: Vendor=10de ID=0004/ {
> +        match($0, /\[([0-9a-fA-F]+)/, arr);
> +        print "0x" arr[1];
> +        exit
> +      }
> +    ')
> +    if [ -n "$dvsec4_reg" ]; then
> +      bus=$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xc))).b)
> +      segment=$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xd))).b)
> +      rp=$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xe))).b)
> +      rc=$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xf))).b)
> +      socket=$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0x10))).b)
> +      echo "$bdf: Bus=$bus, Segment=$segment, RP=$rp, RC=$rc, Socket=$socket"
> +    fi
> +  done < <(lspci -d 10de:)
> +
> +Example output::
> +
> +  0001:00:00.0: Bus=00, Segment=01, RP=00, RC=00, Socket=00
> +  0002:80:00.0: Bus=80, Segment=02, RP=01, RC=01, Socket=00
> +  0002:a0:00.0: Bus=a0, Segment=02, RP=02, RC=01, Socket=00
> +  0002:c0:00.0: Bus=c0, Segment=02, RP=03, RC=01, Socket=00
> +  0002:e0:00.0: Bus=e0, Segment=02, RP=04, RC=01, Socket=00
> +  0003:00:00.0: Bus=00, Segment=03, RP=00, RC=02, Socket=00
> +  0004:00:00.0: Bus=00, Segment=04, RP=00, RC=03, Socket=00
> +  0005:00:00.0: Bus=00, Segment=05, RP=00, RC=04, Socket=00
> +  0005:40:00.0: Bus=40, Segment=05, RP=01, RC=04, Socket=00
> +  0005:c0:00.0: Bus=c0, Segment=05, RP=02, RC=04, Socket=00
> +  0006:00:00.0: Bus=00, Segment=06, RP=00, RC=05, Socket=00
> +  0009:00:00.0: Bus=00, Segment=09, RP=00, RC=00, Socket=01
> +  000a:80:00.0: Bus=80, Segment=0a, RP=01, RC=01, Socket=01
> +  000a:a0:00.0: Bus=a0, Segment=0a, RP=02, RC=01, Socket=01
> +  000a:e0:00.0: Bus=e0, Segment=0a, RP=03, RC=01, Socket=01
> +  000b:00:00.0: Bus=00, Segment=0b, RP=00, RC=02, Socket=01
> +  000c:00:00.0: Bus=00, Segment=0c, RP=00, RC=03, Socket=01
> +  000d:00:00.0: Bus=00, Segment=0d, RP=00, RC=04, Socket=01
> +  000d:40:00.0: Bus=40, Segment=0d, RP=01, RC=04, Socket=01
> +  000d:c0:00.0: Bus=c0, Segment=0d, RP=02, RC=04, Socket=01
> +  000e:00:00.0: Bus=00, Segment=0e, RP=00, RC=05, Socket=01
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index c67667097a3c..42f11f37bddf 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c

>  static struct attribute *generic_pmu_format_attrs[] = {
>  	ARM_CSPMU_FORMAT_EVENT_ATTR,
>  	ARM_CSPMU_FORMAT_FILTER_ATTR,
> @@ -233,6 +270,32 @@ nv_cspmu_get_name(const struct arm_cspmu *cspmu)
>  	return ctx->name;
>  }
>  
> +#if defined(CONFIG_ACPI)
> +static int nv_cspmu_get_inst_id(const struct arm_cspmu *cspmu, u32 *id)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	int ret;
> +
> +	adev = arm_cspmu_acpi_dev_get(cspmu);
Not necessarily related to your patch but it would be really nice to get
clean stubs etc in place so that we can expose this code to the compiler but
then use
	if (IS_CONFIGURED()) etc to provide the fallbacks.

Makes for both easier to read code and better compiler coverage.

> +	if (!adev)
> +		return -ENODEV;
> +
> +	fwnode = acpi_fwnode_handle(adev);
> +	ret = fwnode_property_read_u32(fwnode, "instance_id", id);
> +	if (ret)
> +		dev_err(cspmu->dev, "Failed to get instance ID\n");
> +
> +	acpi_dev_put(adev);

Not necessarily a thing for this series, but would be nice to have a
DEFINE_FREE(acpi_dev_put, struct acpi_device *, if (!IS_ERR_OR_NULL(_T)) acpi_dev_put);

> +	return ret;
> +}
> +#else
> +static int nv_cspmu_get_inst_id(const struct arm_cspmu *cspmu, u32 *id)
> +{
> +	return -EINVAL;
> +}
> +#endif

> +
> +static int pcie_v2_pmu_validate_event(struct arm_cspmu *cspmu,
> +				   struct perf_event *new_ev)
> +{
> +	/*
> +	 * Make sure the events are using same BDF filter since the PCIE-SRC PMU
> +	 * only supports one common BDF filter setting for all of the counters.
> +	 */
> +
> +	int idx;
> +	u32 new_filter, new_rp, new_bdf, new_lead_filter, new_lead_bdf;
> +	struct perf_event *leader, *new_leader;
> +
> +	if (cspmu->impl.ops.is_cycle_counter_event(new_ev))
> +		return 0;
> +
> +	new_leader = new_ev->group_leader;
> +
> +	new_filter = pcie_v2_pmu_event_filter(new_ev);
> +	new_lead_filter = pcie_v2_pmu_event_filter(new_leader);
> +
> +	new_bdf = pcie_v2_pmu_bdf_val_en(new_filter);
> +	new_lead_bdf = pcie_v2_pmu_bdf_val_en(new_lead_filter);
> +
> +	new_rp = FIELD_GET(NV_PCIE_V2_FILTER_PORT, new_filter);
> +
> +	if (new_rp != 0 && new_bdf != 0) {
> +		dev_err(cspmu->dev,
> +			"RP and BDF filtering are mutually exclusive\n");
> +		return -EINVAL;
> +	}
> +
> +	if (new_bdf != new_lead_bdf) {
> +		dev_err(cspmu->dev,
> +			"sibling and leader BDF value should be equal\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Compare BDF filter on existing events. */
> +	idx = find_first_bit(cspmu->hw_events.used_ctrs,
> +			     cspmu->cycle_counter_logical_idx);
> +
> +	if (idx != cspmu->cycle_counter_logical_idx) {
> +		leader = cspmu->hw_events.events[idx]->group_leader;
> +
> +		const u32 lead_filter = pcie_v2_pmu_event_filter(leader);
> +		const u32 lead_bdf = pcie_v2_pmu_bdf_val_en(lead_filter);

The kernel coding standards (not necessarily written down) only commonly allow
for declarations that aren't at the top of scope when using the cleanup.h magic
(so guards, __free() and stuff like that).   So here I'd pull the declaration
of leader into this scope as well.


> +
> +		if (new_lead_bdf != lead_bdf) {
> +			dev_err(cspmu->dev, "only one BDF value is supported\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  enum nv_cspmu_name_fmt {
>  	NAME_FMT_GENERIC,
> -	NAME_FMT_SOCKET
> +	NAME_FMT_SOCKET,
> +	NAME_FMT_SOCKET_INST

Add the trailing comma just to avoid the extra line change like the one you just
made.   The only exception to this is if the enum has a terminating entry for
counting purposes.

>  };
>  
>  struct nv_cspmu_match {
> @@ -430,6 +601,27 @@ static const struct nv_cspmu_match nv_cspmu_match[] = {
>  		.init_data = NULL
>  	  },
>  	},
> +	{
> +	  .prodid = 0x10301000,
> +	  .prodid_mask = NV_PRODID_MASK,
> +	  .name_pattern = "nvidia_pcie_pmu_%u_rc_%u",
> +	  .name_fmt = NAME_FMT_SOCKET_INST,
> +	  .template_ctx = {
> +		.event_attr = pcie_v2_pmu_event_attrs,
> +		.format_attr = pcie_v2_pmu_format_attrs,
> +		.filter_mask = NV_PCIE_V2_FILTER_ID_MASK,
> +		.filter_default_val = NV_PCIE_V2_FILTER_DEFAULT,
> +		.filter2_mask = NV_PCIE_V2_FILTER2_ID_MASK,
> +		.filter2_default_val = NV_PCIE_V2_FILTER2_DEFAULT,
> +		.get_filter = pcie_v2_pmu_event_filter,
> +		.get_filter2 = nv_cspmu_event_filter2,
> +		.init_data = NULL

A side note that I didn't put in the previous similar case.
If a NULL is an 'obvious' default, it is also acceptable to not set
it at all and rely on the c spec to ensure it is set to NULL.

> +	  },
> +	  .ops = {
> +		.validate_event = pcie_v2_pmu_validate_event,
> +		.reset_ev_filter = nv_cspmu_reset_ev_filter,
> +	  }
> +	},
>  	{
>  	  .prodid = 0,
>  	  .prodid_mask = 0,
> @@ -453,7 +645,7 @@ static const struct nv_cspmu_match nv_cspmu_match[] = {
>  static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
>  				  const struct nv_cspmu_match *match)
>  {
> -	char *name;
> +	char *name = NULL;
>  	struct device *dev = cspmu->dev;
>  
>  	static atomic_t pmu_generic_idx = {0};
> @@ -467,13 +659,20 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
>  				       socket);
>  		break;
>  	}
> +	case NAME_FMT_SOCKET_INST: {
> +		const int cpu = cpumask_first(&cspmu->associated_cpus);
> +		const int socket = cpu_to_node(cpu);
> +		u32 inst_id;
> +
> +		if (!nv_cspmu_get_inst_id(cspmu, &inst_id))
> +			name = devm_kasprintf(dev, GFP_KERNEL,
> +					match->name_pattern, socket, inst_id);
> +		break;
> +	}
>  	case NAME_FMT_GENERIC:
>  		name = devm_kasprintf(dev, GFP_KERNEL, match->name_pattern,
>  				       atomic_fetch_inc(&pmu_generic_idx));
>  		break;
> -	default:

Why this change?  to me it doesn't add any particular clarity and is
unrelated to the rest of the patch.

> -		name = NULL;
> -		break;
>  	}
>  
>  	return name;
> @@ -514,8 +713,10 @@ static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>  	cspmu->impl.ctx = ctx;
>  
>  	/* NVIDIA specific callbacks. */
> +	SET_OP(validate_event, impl_ops, match, NULL);
>  	SET_OP(set_cc_filter, impl_ops, match, nv_cspmu_set_cc_filter);
>  	SET_OP(set_ev_filter, impl_ops, match, nv_cspmu_set_ev_filter);
> +	SET_OP(reset_ev_filter, impl_ops, match, NULL);
>  	SET_OP(get_event_attrs, impl_ops, match, nv_cspmu_get_event_attrs);
>  	SET_OP(get_format_attrs, impl_ops, match, nv_cspmu_get_format_attrs);
>  	SET_OP(get_name, impl_ops, match, nv_cspmu_get_name);

