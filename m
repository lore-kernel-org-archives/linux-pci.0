Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943F2737FC
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646755; cv=none; b=MLOmVrdb4AbfnCRw2c8yaMfXWGJRYkHYUa76UQRUGzAlfxYGrfyVbtgF3GZn35pYev2EQAU4UTv4ZlWHzbgW5fZDEoau75wXQ8uR2EUAxuxJk3mNs6uGRgp+PYH0SEPSHYs8Bf0wQBAT4TydlxgXyVA7Z8Av5Zg8FzFm2XaNbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646755; c=relaxed/simple;
	bh=Re7Owuo8/lXs3eaydh7zJSHG2spKhoj3fHDXbr61u+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WdlrvK/YyWEzO+rY/GpWTopgsMckd5zflQINgUJ4BVZBf4b6X3rcq3sBWwMMD2yUNEnjmYVb/oAP5S6e9MIjLzQKwP1o++RUIRzOLNpkENl0y5VfBg4P6BE4kOnim9bJ/aBRkDYiVzVSzJuOifnIGSnkadMGoAdj2xiV8dulSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/ONTMvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/ONTMvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB0C1F000E9;
	Thu, 13 Aug 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786646753;
	bh=7SAaeh1rcujqTvsmWFwlL6T+HMJH2SNSlnWthkqxn3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h/ONTMvlcaoBeykbWe6uo0m+xm1bGzUafSzvSLJC9GNYFC+9m9mQ+nBQb2dOer80J
	 VuPlT9oT6TBp2iLSrqHWXqyCwVzxsSvcXepWj51sEd+jhxBEs1ZpfWyPTcOTQxqsJe
	 +U67/7Bs1SWqtmtc5687aelgKMUmWve96nRa/j9iwYRwQFtzzh/V+Fcq6lH36J0aWo
	 0XEDBp8bCb2T/g+PKC2KTAleKDEywUoCJGzkQZS9dvXwglftuww7teaMKR1srSvt7Y
	 99+/2oMuke1Y2N2ENK8bhT1NqxFKIBjJWk/KYzk0whWJ51SZO8K7o7YZI81otvsfQk
	 5i5PrXmYem1lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 RESEND] Introduce Cray ClusterStor E1000 NVMe slot
 LED driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Hutter" <hutter2@llnl.gov>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <483ad5c9-351d-45f2-a8ef-04a717e97545@llnl.gov>
References: <483ad5c9-351d-45f2-a8ef-04a717e97545@llnl.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 18:45:52 +0000
Message-Id: <20260813184553.2BB0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Calling `craye1k_init()` multiple times corrupts the `smi_watchers=
` list.
- [High] Missing `ipmi_destroy_user()` in `craye1k_smi_gone()` leaves a dan=
gling pointer, leading to a Use-After-Free.
- [High] Missing `reinit_completion()` causes permanent state desynchroniza=
tion for IPMI requests.
- [High] Checking the wrong message length variable leads to an array under=
flow and out-of-bounds read on IPMI error responses.
- [Medium] `craye1k_do_message()` incorrectly treats signal interruptions a=
s successful IPMI transactions.
- [Medium] Multiple SMI registrations blindly overwrite `craye1k_global`, l=
eaking the previously allocated resource.
- [Medium] The driver ignores the IPMI completion code, incorrectly treatin=
g BMC error responses as successful commands.
- [Low] Calling `memcpy` with a NULL pointer is undefined behavior.
--

--- Patch [1]: [PATCH v8 RESEND] Introduce Cray ClusterStor E1000 NVMe slot=
 LED driver ---
commit d5ab81e067eece28c3d260fdea9d4c996bc204c0
Author: Tony Hutter <hutter2@llnl.gov>
Subject: Introduce Cray ClusterStor E1000 NVMe slot LED driver

This commit introduces a driver to control the NVMe slot LEDs on the Cray
ClusterStor E1000 via IPMI. It integrates with the pciehp driver to provide
hotplug attention status callbacks for the 24 NVMe slots.

> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcie=
hp_core.c
> index 2cafd3b26f344..476c8c9d04fbe 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
[ ... ]
> @@ -72,6 +72,22 @@ static int init_slot(struct controller *ctrl)
>  	} else if (ctrl->pcie->port->hotplug_user_indicators) {
>  		ops->get_attention_status =3D pciehp_get_raw_indicator_status;
>  		ops->set_attention_status =3D pciehp_set_raw_indicator_status;
> +	} else if (is_craye1k_slot(ctrl)) {
> +		/*
> +		 * The Cray E1000 driver controls slots 1-24.  Initialize the
> +		 * Cray E1000 driver when slot 1 is seen.
> +		 */
> +		if (PSN(ctrl) =3D=3D 1) {
> +			retval =3D craye1k_init();

[Severity: High]
Can craye1k_init() be called multiple times, for instance, if the pciehp
driver is unbound and rebound, or if multiple root ports exist with a slot =
1?

If init_slot() calls craye1k_init() multiple times, it will repeatedly
call ipmi_smi_watcher_register(). Since craye1k_smi_watcher is statically
allocated, won't calling list_add() multiple times corrupt the
smi_watchers list and cause a kernel panic upon traversal?

> +			if (retval) {
> +				ctrl_err(ctrl,
> +					 "Error loading Cray E1000 extensions");
> +				kfree(ops);
> +				return retval;
> +			}
> +		}
[ ... ]
> diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/p=
ciehp_craye1k.c
> new file mode 100644
> index 0000000000000..9c5bee81fdf88
> --- /dev/null
> +++ b/drivers/pci/hotplug/pciehp_craye1k.c
[ ... ]
> +static void craye1k_new_smi(int iface, struct device *dev)
> +{
[ ... ]
> +	mutex_lock(&craye1k_lock);
> +
> +	/* There's only one node controller so driver data should not be set */
> +	WARN_ON(craye1k_global);
> +
> +	craye1k_global =3D craye1k;

[Severity: Medium]
Will this overwrite craye1k_global and leak memory if multiple IPMI
interfaces are present?

If a system has multiple BMC interfaces (like KCS and BT) probed by
the IPMI subsystem, this callback fires for each one. The newly allocated
craye1k is unconditionally assigned to craye1k_global, orphaning the
previous context and its registered IPMI user.

> +	craye1k->parent =3D craye1k_debugfs_init(craye1k);
> +	mutex_unlock(&craye1k_lock);
[ ... ]
> +static void craye1k_smi_gone(int iface)
> +{
> +	pr_warn("craye1k: Got unexpected smi_gone, iface=3D%d", iface);
> +
> +	mutex_lock(&craye1k_lock);
> +	if (craye1k_global) {
> +		debugfs_remove_recursive(craye1k_global->parent);
> +		kfree(craye1k_global);

[Severity: High]
Does this code leak the IPMI user and introduce a use-after-free?

The IPMI user is registered via ipmi_create_user() in craye1k_new_smi(),
but there doesn't seem to be a corresponding ipmi_destroy_user() call
here before freeing craye1k_global.

If the IPMI user remains active, won't delayed messages or internal timeouts
continue to invoke craye1k_msg_handler()?

craye1k_msg_handler() reads:
    struct craye1k *craye1k =3D user_msg_data;
    if (msg->msgid !=3D craye1k->tx_msg_id) {

This would cast the freed user_msg_data pointer and dereference it.

> +		craye1k_global =3D NULL;
> +	}
> +	mutex_unlock(&craye1k_lock);
> +}
[ ... ]
> +static int craye1k_do_message(struct craye1k *craye1k)
> +{
> +	int rc;
> +	struct completion *read_complete =3D &craye1k->read_complete;
> +	unsigned long tout =3D msecs_to_jiffies(craye1k->completion_timeout_ms);
> +
> +	WARN_ON(!mutex_is_locked(&craye1k_lock));
> +
> +	rc =3D craye1k_send_message(craye1k);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D wait_for_completion_killable_timeout(read_complete, tout);

[Severity: High]
Are we missing a call to reinit_completion() before waiting?

If a previous wait times out or is interrupted, the completion counter
is never decremented. If the delayed response arrives later,
craye1k_msg_handler() will call complete().

Without reinit_completion(), the next call to
wait_for_completion_killable_timeout() will immediately consume the pending
completion and return success without actually waiting for the new response.
Could this permanently desynchronize the driver from the BMC?

> +	if (rc =3D=3D 0) {
> +		/* timed out */
> +		craye1k->completion_timeout++;
> +		return -ETIME;
> +	}

[Severity: Medium]
Does this incorrectly treat signal interruptions as successful IPMI
transactions?

If wait_for_completion_killable_timeout() is interrupted by a signal, it
returns a negative error code like -ERESTARTSYS. Since this only checks
for rc =3D=3D 0 to catch timeouts, won't a negative return value fall throu=
gh
and return 0, assuming success?

> +
> +	return 0;

[Severity: Medium]
Is the IPMI completion code being ignored on success?

When craye1k_msg_handler() receives a response, it extracts and stores the
IPMI completion code into craye1k->rx_result. However, this function
only checks if a response was received at all and returns 0 without inspect=
ing
rx_result.

If the BMC rejects a command, does the driver ignore the error and proceed
as if the state was updated successfully?

> +}
> +
> +/*
> + * __craye1k_do_command() - Do an IPMI command
> + *
> + * Send a command with optional data bytes, and read back response bytes.
> + *
> + * Context: craye1k_lock is already held.
> + * Returns: 0 on success, non-zero on error.
> + */
> +static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cm=
d,
> +				u8 *send_data, u8 send_data_len, u8 *recv_data,
> +				u8 recv_data_len)
> +{
[ ... ]
> +	rc =3D craye1k_do_message(craye1k);
> +	if (rc =3D=3D 0)
> +		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);

[Severity: Low]
Is it possible for memcpy() to be called with a NULL recv_data pointer?

When this is called by craye1k_do_command(), recv_data is explicitly
passed as NULL and recv_data_len as 0. Passing a NULL pointer to
memcpy() is undefined behavior in C, even if the length is 0.
Could this trigger Undefined Behavior Sanitizer warnings?

> +
> +	return rc;
> +}
[ ... ]
> +static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_=
data,
> +			      u8 send_data_len)
> +{
> +	int rc;
> +
> +	rc =3D __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
> +				  send_data_len, NULL, 0);
> +	if (rc !=3D 0) {
> +		/* Error attempting command */
> +		return -1;
> +	}
> +
> +	if (craye1k->tx_msg.data_len =3D=3D 0)
> +		return 0;
> +
> +	/* Return last received byte value */
> +	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];

[Severity: High]
Does this check the wrong message length variable?

It appears to check the length of the transmitted message
(tx_msg.data_len) instead of the received message. If a command with a
payload results in a BMC error, the response contains only a completion
code, making rx_msg_len =3D 0.

In that scenario, tx_msg.data_len > 0 passes the guard, and
evaluating craye1k->rx_msg_len - 1 wraps to ULONG_MAX. Will this trigger
an out-of-bounds memory read on the rx_msg_data array?

> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/483ad5c9-351d-45f2-=
a8ef-04a717e97545@llnl.gov?part=3D1
