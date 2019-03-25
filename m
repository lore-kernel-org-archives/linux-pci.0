Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2774C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B637520700
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553538372;
	bh=3X8JXJhzhuaNy8yAYnEdzs3VSjFwjhv1E67iAuh95ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PpS0lwZK2NtRYh5uvjivvBz7mmIb9Y7Izo02jifJHlSCclxbij2BGymM48477DRjZ
	 FLqv/VjVuXZE87n5H8LOnZTn1HdwqQPorY9vPEQ6lL6+w0WwAtVsPRmtVknV/OL1sM
	 myWT38+qvFNCo9LF6Rin6hKFRQ1001G9qAP6I0nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfCYS0L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfCYS0L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 14:26:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0010920685;
        Mon, 25 Mar 2019 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553538370;
        bh=3X8JXJhzhuaNy8yAYnEdzs3VSjFwjhv1E67iAuh95ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwxk2ETt+AA42EQ7CkpkY7ADenqGmoFaQ10oqxPDBOWqq1jX8LYUER1wFq+1Htn7u
         ykrxj49bPJ0svuTigatgNiXI6/Bnz3wkClioiGW4qYAO6IgfT+O1nFeShadDBBPo2U
         2v2b4Voz21FSgFva0TYtZ5sraA1/Z/S+pqPyAvUo=
Date:   Mon, 25 Mar 2019 13:26:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] CPER: Remove unnecessary use of user-space types
Message-ID: <20190325182608.GS251185@google.com>
References: <20190325181425.247227-1-helgaas@kernel.org>
 <20190325181425.247227-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325181425.247227-5-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 01:14:25PM -0500, helgaas@kernel.org wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> "__u32" and similar types are intended for things exported to user-space,
> including structs used in ioctls; see include/uapi/asm-generic/int-l64.h.
> 
> They are not needed for the CPER struct definitions, which not exported to
> user-space and not used in ioctls.  Replace them with the typical "u32" and
> similar types.  No functional change intended.
> 
> The reason for changing this is to remove the question of "why do we use
> __u32 here instead of u32?"  We should use __u32 when there's a reason for
> it; otherwise, we should prefer u32 for consistency.
> 
> Reference: Documentation/process/coding-style.rst
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Andrew Morton <akpm@linux-foundation.org>

I cc'd you folks because you were part of this conversation:

  https://lore.kernel.org/lkml/1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com/T/#u

I *think* the conclusion there was that this sort of change makes
sense, but I want to make sure.  If it does make sense, I'm surprised
at how much stuff in include/linux/ still uses __u32 when it doesn't
appear to need it.

> ---
>  include/linux/cper.h | 286 +++++++++++++++++++++----------------------
>  1 file changed, 143 insertions(+), 143 deletions(-)
> 
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 2f361a96dc76..cc4980bb0f65 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -323,214 +323,214 @@ enum {
>  /* Record Header, UEFI v2.7 sec N.2.1 */
>  struct cper_record_header {
>  	char	signature[CPER_SIG_SIZE];	/* must be CPER_SIG_RECORD */
> -	__u16	revision;			/* must be CPER_RECORD_REV */
> -	__u32	signature_end;			/* must be CPER_SIG_END */
> -	__u16	section_count;
> -	__u32	error_severity;
> -	__u32	validation_bits;
> -	__u32	record_length;
> -	__u64	timestamp;
> +	u16	revision;			/* must be CPER_RECORD_REV */
> +	u32	signature_end;			/* must be CPER_SIG_END */
> +	u16	section_count;
> +	u32	error_severity;
> +	u32	validation_bits;
> +	u32	record_length;
> +	u64	timestamp;
>  	guid_t	platform_id;
>  	guid_t	partition_id;
>  	guid_t	creator_id;
>  	guid_t	notification_type;
> -	__u64	record_id;
> -	__u32	flags;
> -	__u64	persistence_information;
> -	__u8	reserved[12];			/* must be zero */
> +	u64	record_id;
> +	u32	flags;
> +	u64	persistence_information;
> +	u8	reserved[12];			/* must be zero */
>  };
>  
>  /* Section Descriptor, UEFI v2.7 sec N.2.2 */
>  struct cper_section_descriptor {
> -	__u32	section_offset;		/* Offset in bytes of the
> +	u32	section_offset;		/* Offset in bytes of the
>  					 *  section body from the base
>  					 *  of the record header */
> -	__u32	section_length;
> -	__u16	revision;		/* must be CPER_RECORD_REV */
> -	__u8	validation_bits;
> -	__u8	reserved;		/* must be zero */
> -	__u32	flags;
> +	u32	section_length;
> +	u16	revision;		/* must be CPER_RECORD_REV */
> +	u8	validation_bits;
> +	u8	reserved;		/* must be zero */
> +	u32	flags;
>  	guid_t	section_type;
>  	guid_t	fru_id;
> -	__u32	section_severity;
> -	__u8	fru_text[20];
> +	u32	section_severity;
> +	u8	fru_text[20];
>  };
>  
>  /* Generic Processor Error Section, UEFI v2.7 sec N.2.4.1 */
>  struct cper_sec_proc_generic {
> -	__u64	validation_bits;
> -	__u8	proc_type;
> -	__u8	proc_isa;
> -	__u8	proc_error_type;
> -	__u8	operation;
> -	__u8	flags;
> -	__u8	level;
> -	__u16	reserved;
> -	__u64	cpu_version;
> +	u64	validation_bits;
> +	u8	proc_type;
> +	u8	proc_isa;
> +	u8	proc_error_type;
> +	u8	operation;
> +	u8	flags;
> +	u8	level;
> +	u16	reserved;
> +	u64	cpu_version;
>  	char	cpu_brand[128];
> -	__u64	proc_id;
> -	__u64	target_addr;
> -	__u64	requestor_id;
> -	__u64	responder_id;
> -	__u64	ip;
> +	u64	proc_id;
> +	u64	target_addr;
> +	u64	requestor_id;
> +	u64	responder_id;
> +	u64	ip;
>  };
>  
>  /* IA32/X64 Processor Error Section, UEFI v2.7 sec N.2.4.2 */
>  struct cper_sec_proc_ia {
> -	__u64	validation_bits;
> -	__u64	lapic_id;
> -	__u8	cpuid[48];
> +	u64	validation_bits;
> +	u64	lapic_id;
> +	u8	cpuid[48];
>  };
>  
>  /* IA32/X64 Processor Error Information Structure, UEFI v2.7 sec N.2.4.2.1 */
>  struct cper_ia_err_info {
>  	guid_t	err_type;
> -	__u64	validation_bits;
> -	__u64	check_info;
> -	__u64	target_id;
> -	__u64	requestor_id;
> -	__u64	responder_id;
> -	__u64	ip;
> +	u64	validation_bits;
> +	u64	check_info;
> +	u64	target_id;
> +	u64	requestor_id;
> +	u64	responder_id;
> +	u64	ip;
>  };
>  
>  /* IA32/X64 Processor Context Information Structure, UEFI v2.7 sec N.2.4.2.2 */
>  struct cper_ia_proc_ctx {
> -	__u16	reg_ctx_type;
> -	__u16	reg_arr_size;
> -	__u32	msr_addr;
> -	__u64	mm_reg_addr;
> +	u16	reg_ctx_type;
> +	u16	reg_arr_size;
> +	u32	msr_addr;
> +	u64	mm_reg_addr;
>  };
>  
>  /* ARM Processor Error Section, UEFI v2.7 sec N.2.4.4 */
>  struct cper_sec_proc_arm {
> -	__u32	validation_bits;
> -	__u16	err_info_num;		/* Number of Processor Error Info */
> -	__u16	context_info_num;	/* Number of Processor Context Info Records*/
> -	__u32	section_length;
> -	__u8	affinity_level;
> -	__u8	reserved[3];		/* must be zero */
> -	__u64	mpidr;
> -	__u64	midr;
> -	__u32	running_state;		/* Bit 0 set - Processor running. PSCI = 0 */
> -	__u32	psci_state;
> +	u32	validation_bits;
> +	u16	err_info_num;		/* Number of Processor Error Info */
> +	u16	context_info_num;	/* Number of Processor Context Info Records*/
> +	u32	section_length;
> +	u8	affinity_level;
> +	u8	reserved[3];		/* must be zero */
> +	u64	mpidr;
> +	u64	midr;
> +	u32	running_state;		/* Bit 0 set - Processor running. PSCI = 0 */
> +	u32	psci_state;
>  };
>  
>  /* ARM Processor Error Information Structure, UEFI v2.7 sec N.2.4.4.1 */
>  struct cper_arm_err_info {
> -	__u8	version;
> -	__u8	length;
> -	__u16	validation_bits;
> -	__u8	type;
> -	__u16	multiple_error;
> -	__u8	flags;
> -	__u64	error_info;
> -	__u64	virt_fault_addr;
> -	__u64	physical_fault_addr;
> +	u8	version;
> +	u8	length;
> +	u16	validation_bits;
> +	u8	type;
> +	u16	multiple_error;
> +	u8	flags;
> +	u64	error_info;
> +	u64	virt_fault_addr;
> +	u64	physical_fault_addr;
>  };
>  
>  /* ARM Processor Context Information Structure, UEFI v2.7 sec N.2.4.4.2 */
>  struct cper_arm_ctx_info {
> -	__u16	version;
> -	__u16	type;
> -	__u32	size;
> +	u16	version;
> +	u16	type;
> +	u32	size;
>  };
>  
>  /* Old Memory Error Section, UEFI v2.1, v2.2 */
>  struct cper_sec_mem_err_old {
> -	__u64	validation_bits;
> -	__u64	error_status;
> -	__u64	physical_addr;
> -	__u64	physical_addr_mask;
> -	__u16	node;
> -	__u16	card;
> -	__u16	module;
> -	__u16	bank;
> -	__u16	device;
> -	__u16	row;
> -	__u16	column;
> -	__u16	bit_pos;
> -	__u64	requestor_id;
> -	__u64	responder_id;
> -	__u64	target_id;
> -	__u8	error_type;
> +	u64	validation_bits;
> +	u64	error_status;
> +	u64	physical_addr;
> +	u64	physical_addr_mask;
> +	u16	node;
> +	u16	card;
> +	u16	module;
> +	u16	bank;
> +	u16	device;
> +	u16	row;
> +	u16	column;
> +	u16	bit_pos;
> +	u64	requestor_id;
> +	u64	responder_id;
> +	u64	target_id;
> +	u8	error_type;
>  };
>  
>  /* Memory Error Section (UEFI >= v2.3), UEFI v2.7 sec N.2.5 */
>  struct cper_sec_mem_err {
> -	__u64	validation_bits;
> -	__u64	error_status;
> -	__u64	physical_addr;
> -	__u64	physical_addr_mask;
> -	__u16	node;
> -	__u16	card;
> -	__u16	module;
> -	__u16	bank;
> -	__u16	device;
> -	__u16	row;
> -	__u16	column;
> -	__u16	bit_pos;
> -	__u64	requestor_id;
> -	__u64	responder_id;
> -	__u64	target_id;
> -	__u8	error_type;
> -	__u8	reserved;
> -	__u16	rank;
> -	__u16	mem_array_handle;	/* "card handle" in UEFI 2.4 */
> -	__u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
> +	u64	validation_bits;
> +	u64	error_status;
> +	u64	physical_addr;
> +	u64	physical_addr_mask;
> +	u16	node;
> +	u16	card;
> +	u16	module;
> +	u16	bank;
> +	u16	device;
> +	u16	row;
> +	u16	column;
> +	u16	bit_pos;
> +	u64	requestor_id;
> +	u64	responder_id;
> +	u64	target_id;
> +	u8	error_type;
> +	u8	reserved;
> +	u16	rank;
> +	u16	mem_array_handle;	/* "card handle" in UEFI 2.4 */
> +	u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
>  };
>  
>  struct cper_mem_err_compact {
> -	__u64	validation_bits;
> -	__u16	node;
> -	__u16	card;
> -	__u16	module;
> -	__u16	bank;
> -	__u16	device;
> -	__u16	row;
> -	__u16	column;
> -	__u16	bit_pos;
> -	__u64	requestor_id;
> -	__u64	responder_id;
> -	__u64	target_id;
> -	__u16	rank;
> -	__u16	mem_array_handle;
> -	__u16	mem_dev_handle;
> +	u64	validation_bits;
> +	u16	node;
> +	u16	card;
> +	u16	module;
> +	u16	bank;
> +	u16	device;
> +	u16	row;
> +	u16	column;
> +	u16	bit_pos;
> +	u64	requestor_id;
> +	u64	responder_id;
> +	u64	target_id;
> +	u16	rank;
> +	u16	mem_array_handle;
> +	u16	mem_dev_handle;
>  };
>  
>  /* PCI Express Error Section, UEFI v2.7 sec N.2.7 */
>  struct cper_sec_pcie {
> -	__u64		validation_bits;
> -	__u32		port_type;
> +	u64		validation_bits;
> +	u32		port_type;
>  	struct {
> -		__u8	minor;
> -		__u8	major;
> -		__u8	reserved[2];
> +		u8	minor;
> +		u8	major;
> +		u8	reserved[2];
>  	}		version;
> -	__u16		command;
> -	__u16		status;
> -	__u32		reserved;
> +	u16		command;
> +	u16		status;
> +	u32		reserved;
>  	struct {
> -		__u16	vendor_id;
> -		__u16	device_id;
> -		__u8	class_code[3];
> -		__u8	function;
> -		__u8	device;
> -		__u16	segment;
> -		__u8	bus;
> -		__u8	secondary_bus;
> -		__u16	slot;
> -		__u8	reserved;
> +		u16	vendor_id;
> +		u16	device_id;
> +		u8	class_code[3];
> +		u8	function;
> +		u8	device;
> +		u16	segment;
> +		u8	bus;
> +		u8	secondary_bus;
> +		u16	slot;
> +		u8	reserved;
>  	}		device_id;
>  	struct {
> -		__u32	lower;
> -		__u32	upper;
> +		u32	lower;
> +		u32	upper;
>  	}		serial_number;
>  	struct {
> -		__u16	secondary_status;
> -		__u16	control;
> +		u16	secondary_status;
> +		u16	control;
>  	}		bridge;
> -	__u8	capability[60];
> -	__u8	aer_info[96];
> +	u8	capability[60];
> +	u8	aer_info[96];
>  };
>  
>  /* Reset to default packing */
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
