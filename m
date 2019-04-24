Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD8C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C40A2089F
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116189;
	bh=Kwn0Aue59nm7gbGIJwBk+SRASWzJlK5cH0KkXFtrIzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bXbUHMkP4/y8rleIefEbR8j/ezLC8y9+/IS2BcifrTB4h0S0u8lPGFcVkCYQkRrvk
	 7Gt31LNpNU0glH+yzesujwWdmhEwi3G/8vxNwppuMOrDHbS6/LHJ2hlVTh/u1AY7fu
	 tM+f0zrdmQxAfxLqme7O2DfUS/SZTGmCNHlewYYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfDXO3s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:29:48 -0400
Received: from casper.infradead.org ([85.118.1.10]:45130 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDXO3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 10:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WjR4HTV7qgFEVgSxaDBz+HL+YULhchp0ntpB/fbNwAo=; b=nl0K/trfcEFfl0fgUuvgB/Cy7s
        p5Su2AVROlsAVpv7mQl2w/BdxTiTlI14jiLTM9n8S4NnERt+Id5SvFsdWx/wMTK1pvf0CrbgBuyOM
        HA2isB2qRyojA6i8EfF2Fe62oXVCIfY7moAnjrYczDHnHKfbpgObq3KZWDZ8HJ67N9Yd+B+hFcmVG
        lqRX7u4ffK9zcpt/UK8O64BwSabPiVd0l5YE/dKOw1K4ijUg0JYFs00i36K3y/Wxhz5a2A+1qUH67
        vqjro7xuJ/aMZ6/hIfl2nVdB/tlj+sdp9jWWNJofmt657NEho5xbxWRx6SOboM5DuLx620VQEXz+A
        jVfoLK1A==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJIu7-0007Pd-QY; Wed, 24 Apr 2019 14:29:44 +0000
Date:   Wed, 24 Apr 2019 11:29:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 19/63] Documentation: ACPI: move
 apei/output_format.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424112937.7b0f2b01@coco.lan>
In-Reply-To: <20190423162932.21428-20-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-20-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:48 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion changes:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/acpi/apei/output_format.txt     | 147 -----------------
>  .../acpi/apei/output_format.rst               | 150 ++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  3 files changed, 151 insertions(+), 147 deletions(-)
>  delete mode 100644 Documentation/acpi/apei/output_format.txt
>  create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst
> 
> diff --git a/Documentation/acpi/apei/output_format.txt b/Documentation/acpi/apei/output_format.txt
> deleted file mode 100644
> index 0c49c197c47a..000000000000
> --- a/Documentation/acpi/apei/output_format.txt
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -                     APEI output format
> -                     ~~~~~~~~~~~~~~~~~~
> -
> -APEI uses printk as hardware error reporting interface, the output
> -format is as follow.
> -
> -<error record> :=
> -APEI generic hardware error status
> -severity: <integer>, <severity string>
> -section: <integer>, severity: <integer>, <severity string>
> -flags: <integer>
> -<section flags strings>
> -fru_id: <uuid string>
> -fru_text: <string>
> -section_type: <section type string>
> -<section data>
> -
> -<severity string>* := recoverable | fatal | corrected | info
> -
> -<section flags strings># :=
> -[primary][, containment warning][, reset][, threshold exceeded]\
> -[, resource not accessible][, latent error]
> -
> -<section type string> := generic processor error | memory error | \
> -PCIe error | unknown, <uuid string>
> -
> -<section data> :=
> -<generic processor section data> | <memory section data> | \
> -<pcie section data> | <null>
> -
> -<generic processor section data> :=
> -[processor_type: <integer>, <proc type string>]
> -[processor_isa: <integer>, <proc isa string>]
> -[error_type: <integer>
> -<proc error type strings>]
> -[operation: <integer>, <proc operation string>]
> -[flags: <integer>
> -<proc flags strings>]
> -[level: <integer>]
> -[version_info: <integer>]
> -[processor_id: <integer>]
> -[target_address: <integer>]
> -[requestor_id: <integer>]
> -[responder_id: <integer>]
> -[IP: <integer>]
> -
> -<proc type string>* := IA32/X64 | IA64
> -
> -<proc isa string>* := IA32 | IA64 | X64
> -
> -<processor error type strings># :=
> -[cache error][, TLB error][, bus error][, micro-architectural error]
> -
> -<proc operation string>* := unknown or generic | data read | data write | \
> -instruction execution
> -
> -<proc flags strings># :=
> -[restartable][, precise IP][, overflow][, corrected]
> -
> -<memory section data> :=
> -[error_status: <integer>]
> -[physical_address: <integer>]
> -[physical_address_mask: <integer>]
> -[node: <integer>]
> -[card: <integer>]
> -[module: <integer>]
> -[bank: <integer>]
> -[device: <integer>]
> -[row: <integer>]
> -[column: <integer>]
> -[bit_position: <integer>]
> -[requestor_id: <integer>]
> -[responder_id: <integer>]
> -[target_id: <integer>]
> -[error_type: <integer>, <mem error type string>]
> -
> -<mem error type string>* :=
> -unknown | no error | single-bit ECC | multi-bit ECC | \
> -single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
> -target abort | parity error | watchdog timeout | invalid address | \
> -mirror Broken | memory sparing | scrub corrected error | \
> -scrub uncorrected error
> -
> -<pcie section data> :=
> -[port_type: <integer>, <pcie port type string>]
> -[version: <integer>.<integer>]
> -[command: <integer>, status: <integer>]
> -[device_id: <integer>:<integer>:<integer>.<integer>
> -slot: <integer>
> -secondary_bus: <integer>
> -vendor_id: <integer>, device_id: <integer>
> -class_code: <integer>]
> -[serial number: <integer>, <integer>]
> -[bridge: secondary_status: <integer>, control: <integer>]
> -[aer_status: <integer>, aer_mask: <integer>
> -<aer status string>
> -[aer_uncor_severity: <integer>]
> -aer_layer=<aer layer string>, aer_agent=<aer agent string>
> -aer_tlp_header: <integer> <integer> <integer> <integer>]
> -
> -<pcie port type string>* := PCIe end point | legacy PCI end point | \
> -unknown | unknown | root port | upstream switch port | \
> -downstream switch port | PCIe to PCI/PCI-X bridge | \
> -PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
> -root complex event collector
> -
> -if section severity is fatal or recoverable
> -<aer status string># :=
> -unknown | unknown | unknown | unknown | Data Link Protocol | \
> -unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
> -Poisoned TLP | Flow Control Protocol | Completion Timeout | \
> -Completer Abort | Unexpected Completion | Receiver Overflow | \
> -Malformed TLP | ECRC | Unsupported Request
> -else
> -<aer status string># :=
> -Receiver Error | unknown | unknown | unknown | unknown | unknown | \
> -Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
> -Replay Timer Timeout | Advisory Non-Fatal
> -fi
> -
> -<aer layer string> :=
> -Physical Layer | Data Link Layer | Transaction Layer
> -
> -<aer agent string> :=
> -Receiver ID | Requester ID | Completer ID | Transmitter ID
> -
> -Where, [] designate corresponding content is optional
> -
> -All <field string> description with * has the following format:
> -
> -field: <integer>, <field string>
> -
> -Where value of <integer> should be the position of "string" in <field
> -string> description. Otherwise, <field string> will be "unknown".  
> -
> -All <field strings> description with # has the following format:
> -
> -field: <integer>
> -<field strings>
> -
> -Where each string in <fields strings> corresponding to one set bit of
> -<integer>. The bit position is the position of "string" in <field
> -strings> description.  
> -
> -For more detailed explanation of every field, please refer to UEFI
> -specification version 2.3 or later, section Appendix N: Common
> -Platform Error Record.
> diff --git a/Documentation/firmware-guide/acpi/apei/output_format.rst b/Documentation/firmware-guide/acpi/apei/output_format.rst
> new file mode 100644
> index 000000000000..c2e7ebddb529
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/apei/output_format.rst
> @@ -0,0 +1,150 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +APEI output format
> +==================
> +
> +APEI uses printk as hardware error reporting interface, the output
> +format is as follow::
> +
> +        <error record> :=
> +        APEI generic hardware error status
> +        severity: <integer>, <severity string>
> +        section: <integer>, severity: <integer>, <severity string>
> +        flags: <integer>
> +        <section flags strings>
> +        fru_id: <uuid string>
> +        fru_text: <string>
> +        section_type: <section type string>
> +        <section data>
> +
> +        <severity string>* := recoverable | fatal | corrected | info
> +
> +        <section flags strings># :=
> +        [primary][, containment warning][, reset][, threshold exceeded]\
> +        [, resource not accessible][, latent error]
> +
> +        <section type string> := generic processor error | memory error | \
> +        PCIe error | unknown, <uuid string>
> +
> +        <section data> :=
> +        <generic processor section data> | <memory section data> | \
> +        <pcie section data> | <null>
> +
> +        <generic processor section data> :=
> +        [processor_type: <integer>, <proc type string>]
> +        [processor_isa: <integer>, <proc isa string>]
> +        [error_type: <integer>
> +        <proc error type strings>]
> +        [operation: <integer>, <proc operation string>]
> +        [flags: <integer>
> +        <proc flags strings>]
> +        [level: <integer>]
> +        [version_info: <integer>]
> +        [processor_id: <integer>]
> +        [target_address: <integer>]
> +        [requestor_id: <integer>]
> +        [responder_id: <integer>]
> +        [IP: <integer>]
> +
> +        <proc type string>* := IA32/X64 | IA64
> +
> +        <proc isa string>* := IA32 | IA64 | X64
> +
> +        <processor error type strings># :=
> +        [cache error][, TLB error][, bus error][, micro-architectural error]
> +
> +        <proc operation string>* := unknown or generic | data read | data write | \
> +        instruction execution
> +
> +        <proc flags strings># :=
> +        [restartable][, precise IP][, overflow][, corrected]
> +
> +        <memory section data> :=
> +        [error_status: <integer>]
> +        [physical_address: <integer>]
> +        [physical_address_mask: <integer>]
> +        [node: <integer>]
> +        [card: <integer>]
> +        [module: <integer>]
> +        [bank: <integer>]
> +        [device: <integer>]
> +        [row: <integer>]
> +        [column: <integer>]
> +        [bit_position: <integer>]
> +        [requestor_id: <integer>]
> +        [responder_id: <integer>]
> +        [target_id: <integer>]
> +        [error_type: <integer>, <mem error type string>]
> +
> +        <mem error type string>* :=
> +        unknown | no error | single-bit ECC | multi-bit ECC | \
> +        single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
> +        target abort | parity error | watchdog timeout | invalid address | \
> +        mirror Broken | memory sparing | scrub corrected error | \
> +        scrub uncorrected error
> +
> +        <pcie section data> :=
> +        [port_type: <integer>, <pcie port type string>]
> +        [version: <integer>.<integer>]
> +        [command: <integer>, status: <integer>]
> +        [device_id: <integer>:<integer>:<integer>.<integer>
> +        slot: <integer>
> +        secondary_bus: <integer>
> +        vendor_id: <integer>, device_id: <integer>
> +        class_code: <integer>]
> +        [serial number: <integer>, <integer>]
> +        [bridge: secondary_status: <integer>, control: <integer>]
> +        [aer_status: <integer>, aer_mask: <integer>
> +        <aer status string>
> +        [aer_uncor_severity: <integer>]
> +        aer_layer=<aer layer string>, aer_agent=<aer agent string>
> +        aer_tlp_header: <integer> <integer> <integer> <integer>]
> +
> +        <pcie port type string>* := PCIe end point | legacy PCI end point | \
> +        unknown | unknown | root port | upstream switch port | \
> +        downstream switch port | PCIe to PCI/PCI-X bridge | \
> +        PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
> +        root complex event collector
> +
> +        if section severity is fatal or recoverable
> +        <aer status string># :=
> +        unknown | unknown | unknown | unknown | Data Link Protocol | \
> +        unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
> +        Poisoned TLP | Flow Control Protocol | Completion Timeout | \
> +        Completer Abort | Unexpected Completion | Receiver Overflow | \
> +        Malformed TLP | ECRC | Unsupported Request
> +        else
> +        <aer status string># :=
> +        Receiver Error | unknown | unknown | unknown | unknown | unknown | \
> +        Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
> +        Replay Timer Timeout | Advisory Non-Fatal
> +        fi
> +
> +        <aer layer string> :=
> +        Physical Layer | Data Link Layer | Transaction Layer
> +
> +        <aer agent string> :=
> +        Receiver ID | Requester ID | Completer ID | Transmitter ID
> +
> +Where, [] designate corresponding content is optional
> +
> +All <field string> description with * has the following format::
> +
> +        field: <integer>, <field string>
> +
> +Where value of <integer> should be the position of "string" in <field
> +string> description. Otherwise, <field string> will be "unknown".  
> +
> +All <field strings> description with # has the following format::
> +
> +        field: <integer>
> +        <field strings>
> +
> +Where each string in <fields strings> corresponding to one set bit of
> +<integer>. The bit position is the position of "string" in <field
> +strings> description.  
> +
> +For more detailed explanation of every field, please refer to UEFI
> +specification version 2.3 or later, section Appendix N: Common
> +Platform Error Record.
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index e9f253d54897..869badba6d7a 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -17,6 +17,7 @@ ACPI Support
>     DSD-properties-rules
>     debug
>     aml-debugger
> +   apei/output_format
>     gpio-properties
>     i2c-muxes
>     acpi-lid



Thanks,
Mauro
